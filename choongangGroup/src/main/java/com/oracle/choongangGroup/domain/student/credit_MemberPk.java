package com.oracle.choongangGroup.domain.student;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;


@AllArgsConstructor
@Getter
@NoArgsConstructor
@EqualsAndHashCode
public class credit_MemberPk implements Serializable {
	 private String credit_id;
	 private String mem_userid;
	
	
}