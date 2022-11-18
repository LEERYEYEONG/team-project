package com.oracle.choongangGroup.domain.manager;

import javax.persistence.*;

import lombok.Data;

@Entity
@Data
public class Approval {
    
	@Enumerated(EnumType.STRING)
	private ApprovalForm approvalForm;
	
    @Id
    private int approval_no;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    private Member member;
    
    @Column(name = "mid_approver")
    private String midApprover;
    
    @Column(name = "fin_approver")
    private String finApprover;
    private String title;
    
    @Column(name = "item_need")
    private String need;
    
    @Column(name = "item_quantity")
    private String quantity;
    
    @Column(name = "approval_content")
    private String content;
    
    @Column(name = "item_price")
    private String price;
    
    @Column(name = "server_file_name")
    private String ServerFileName;
    
    @Column(name = "org_file_name")
    private String OrgFileName;
    
    @Column(name = "file_path")
    private String filePath;
    
    @Column(name = "mid_approval_ok")
    private String midApprovalOk;
    
    @Column(name = "fin_approval_ok")
    private String finApprovalOk;
    
    @Enumerated(EnumType.STRING)
    private ApprovalStatus approvalStatus;
    
    @Column(name = "approval_start")
    private String approvalStart;
    
    @Column(name = "approval_end")
    private String approvalEnd;
    
    @Column(name = "mid_approval_opinion")
    private String midApprovalOpinion;
    
    @Column(name = "fin_approval_opinion")
    private String finApprovalOpinion;


}
