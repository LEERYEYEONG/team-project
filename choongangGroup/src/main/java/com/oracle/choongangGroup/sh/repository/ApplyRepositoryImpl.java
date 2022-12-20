package com.oracle.choongangGroup.sh.repository;

import java.util.ArrayList;
import java.util.List;


import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.persistence.TypedQuery;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.oracle.choongangGroup.changhun.JPA.Member;
import com.oracle.choongangGroup.sh.domain.ApplicationLec;
import com.oracle.choongangGroup.sh.domain.ApplyTime;
import com.oracle.choongangGroup.sh.domain.Lecture;

import lombok.RequiredArgsConstructor;
@Repository
@RequiredArgsConstructor
public class ApplyRepositoryImpl implements ApplyRepository {

   private final EntityManager em;
   
   //강의 전체 조회
   @Override
   public List<Lecture> lectureListAll() {
      List<Lecture> list = em.createQuery("select l from Lecture l", Lecture.class).getResultList();
      return list;
   }

   //사용자코드로 사용자정보불러오기
   @Override
   public Member memberFindOne(String userid) {
      Member member = em.find(Member.class, userid);
      return member;
   }

   //강의코드로 강의정보 불러오기
   @Override
   public Lecture lectureFindOne(Long lecId) {
      Lecture lecture = em.find(Lecture.class, lecId);
      return lecture;
   }
   
   //장바구니 강의 리스트 조회
   @Override
   public List<ApplicationLec> likeListAll(String userid) {
      String jpql = "select a from ApplicationLec a where a.member.userid = :userid and a.gubun = 1L";
      List<ApplicationLec> list = em.createQuery(jpql,ApplicationLec.class)
                           .setParameter("userid", userid)
                           .getResultList();
      return list;
   }
   
   //장바구니, 수강신청
   @Override
   public int apply(ApplicationLec applyLec) {
      System.out.println("Apply repository apply start...");
      int result = 1; //0:강의중복, 1:성공, 2:시간중복, 3:학점초과
      String userid = applyLec.getMember().getUserid();
      Long lecId = applyLec.getLecture().getId();
      String year = applyLec.getLecture().getYear();
      String semester = applyLec.getLecture().getSemester();
      
      int lecResult = lecOverlap(applyLec,year,semester); //강의 중복 조회 / 1-->중복없음, 0-->중복있음
      int timeResult = timeOverLap(applyLec,year,semester);//시간 중복 조회 / 1-->중복없음, 2-->중복있음
      if(lecResult == 1 && timeResult == 1) { //중복된 강의가 없을때만 등록
         List<ApplicationLec> list = em.createQuery("Select a from ApplicationLec a where a.member.userid = :userid and a.lecture.year = :year "
                     + "and a.lecture.semester = :semester and a.gubun = 2L",ApplicationLec.class)
               .setParameter("userid", userid).setParameter("year", year).setParameter("semester", semester).getResultList();
         if(list.size()==0) {
            applyLec.getMember().setCount(0L);
         }
         
         Long count = applyLec.getMember().getCount();
         Long unitScore = applyLec.getLecture().getUnitScore();
         applyLec.getMember().setCount(count + unitScore);
         if(applyLec.getMember().getCount()>21) { //총 신청학점이 21학점 초과시 신청불가
            result = 3;
         }else {
            String jpql = "select a from ApplicationLec a where a.member.userid = :userid and a.lecture.id = :id  "
                  + "and a.lecture.year = :year and a.lecture.semester = :semester and a.gubun = 1L";
            ApplicationLec a = em.createQuery(jpql,ApplicationLec.class).setParameter("userid", userid).setParameter("id", lecId).setParameter("year", year).setParameter("semester", semester).getSingleResult();
            em.remove(a);
            em.persist(applyLec); 
         }
      }else if(lecResult != 1) {
         result = lecResult;
      }else {
         result = timeResult;
      }
   
      return result;
   }
   //강의 중복 검사
   public int lecOverlap(ApplicationLec applyLec, String year, String semester) {
      //result = 1 --> 중복없음
      //result = 0 --> 중복존재
      int result = 0;
      String userid = applyLec.getMember().getUserid();
      Long lecId = applyLec.getLecture().getId();
      Long gubun = applyLec.getGubun();
      String jpql = "select a from ApplicationLec a where a.member.userid = :userid and a.lecture.id = :lecId and a.gubun = :gubun "
                                        + "and a.lecture.year = :year and a.lecture.semester = :semester";
      List<ApplicationLec> list = em.createQuery(jpql,ApplicationLec.class)
                                    .setParameter("userid", userid)
                                    .setParameter("lecId", lecId)
                                    .setParameter("gubun", gubun)
                                    .setParameter("year", year)
                                    .setParameter("semester", semester)
                                    .getResultList();   
      //중복강의 존재
      if(list.size()>0) {         
         result = 0;
      //중복강의 없음
      }else {         
         result = 1;
      }
      return result;
      
   }
   
   //시간중복 검사
   public int timeOverLap(ApplicationLec applyLec, String year, String semester) {
      //result = 1 --> 중복없음
      //result = 2 --> 시간 중복됨
      int result = 1;
      Long gubun = applyLec.getGubun(); //장바구니,수강신청 구분
      String userid = applyLec.getMember().getUserid();      
      String jpql = "select a from ApplicationLec a where a.member.userid = :userid and a.gubun = :gubun "
                                         + "and a.lecture.year = :year and a.lecture.semester = :semester";
      //사용자의  년도,학기,구분이 동일한 강의들 list
      List<ApplicationLec> applyList = em.createQuery(jpql,ApplicationLec.class)
                              .setParameter("userid", userid)
                              .setParameter("gubun", gubun)
                              .setParameter("year", year)
                              .setParameter("semester", semester)
                              .getResultList();
      ////강의들의 시간들 누적해서 list에 담기
      List<String> timetable = new ArrayList<String>();
      
         //찾은 전체 강의만큼 반복
         for(int i=0; i<applyList.size(); i++) {
            String day1 = applyList.get(i).getLecture().getDay1();//강의 요일 조회
            int time1 = Integer.parseInt(applyList.get(i).getLecture().getTime1());//강의 시작 교시 조회
            int hour1 = Integer.parseInt(applyList.get(i).getLecture().getHour1());//강의 시간  조회
            
            //강의별 시간 누적
            for(int j=0; j<hour1; j++) {
               timetable.add(day1+(time1+j));
            }
            
   
            String day2 = applyList.get(i).getLecture().getDay2();
            if(day2 != null) { //강의가 한주에 하루만 있을 경우 실행X
               int time2 = Integer.parseInt(applyList.get(i).getLecture().getTime2());//강의 시작 교시 조회
               int hour2 = Integer.parseInt(applyList.get(i).getLecture().getHour2());//강의 시간  조회
               
               for(int j=0; j<hour2; j++) {
                  timetable.add(day2+(time2+j));
               }         
            }
         }
      
      ////신청한 강의 시간 추출
      List<String> applyTime = new ArrayList<String>();
   
      String applyDay1 = applyLec.getLecture().getDay1();
      int applyTime1 = Integer.parseInt(applyLec.getLecture().getTime1());
      int applyHour1 = Integer.parseInt(applyLec.getLecture().getHour1());
      
      for(int j=0; j<applyHour1; j++) {
         applyTime.add(applyDay1+(applyTime1+j));
      }   
      
      String applyDay2 = applyLec.getLecture().getDay2();
      
      if(applyDay2 != null) {
         int applyTime2 = Integer.parseInt(applyLec.getLecture().getTime2());
         int applyHour2 = Integer.parseInt(applyLec.getLecture().getHour2());
         for(int j=0; j<applyHour2; j++) {
            applyTime.add(applyDay2+(applyTime2+j));
         }
      }
            
      
      ////기존강의시간과 신청한 강의 시간 중복 비교
      for(int i =0; i<timetable.size(); i++) {
         for(int j=0; j<applyTime.size();j++) {
            if(timetable.get(i).equals(applyTime.get(j))) {
               result = 2;
            }
         }
      }
      System.out.println("ApplyRepository timeOverlap result-->"+result);
      return result;
   }

   
   





}