/*
//////////////////////////////////////
//      @author Vaibhav Jain     //
/////////////////////////////////////
Version :   1.0
Date : 13th July 2015

21 Sept 2015            //create task for mobile app for apple oid

5th Oct 2015 //Call back functionality for CS

14th Oct 2015 //Contact Priority matrix - Last RM case modified date
*/
    public class caseTrgHelperCls{
        
    //Send Approval for Case    
    public void SendApprovalForCase(Id caseId){
       
       Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
       req1.setComments('Submitting request for approval.');
       req1.setProcessDefinitionNameOrId('Approval_Cases_Submitted_to_Finance');
       req1.setObjectId(caseId);
       Approval.ProcessResult result = Approval.process(req1); 
       System.assert(result.isSuccess());        
    }
    Public Static Boolean byPassFcc=false; 
    Public Static Boolean isRunOnce1=false;
        
        public void OnBeforeInsert(List<Case> newValues){  
        }
        
        public void OnAfterInsert(Map<Id,Case> newMapValues){
            //Client Proficieny
            Set<Id> setIdOfContact = new Set<Id>();
            
            //List<CaseCallBack__c> lstCCB = new List<CaseCallBack__c>();
            
            for(Case instOfCase: newMapValues.values()){            
                if(instOfCase.Client_Proficiency_Level__c != null){
                    if(instOfCase.ContactId != null){
                        if(string.valueOf(instOfCase.ContactId).startsWith('003')){
                            setIdOfContact.add(instOfCase.ContactId);
                        }
                    }
                }
                /*Call back functionality for CS
                if(instOfCase.Call_Back_Schedule__c != null){ 
                    scheduledBatchable m = new scheduledBatchable(instOfCase.id);
                    scheduledBatchableUserEmail mOfUser = new scheduledBatchableUserEmail(instOfCase.id);
                    scheduledBatchableManagerSec mSecMan = new scheduledBatchableManagerSec(instOfCase.id);
                    
                    system.debug(instOfCase.Call_Back_Schedule__c);
                    system.debug(system.now());
                    Integer intTempMins = instOfCase.Call_Back_Schedule__c.minute() - 15;
                    String chronExpression = '' + instOfCase.Call_Back_Schedule__c.second() + ' ' + intTempMins  + ' ' + instOfCase.Call_Back_Schedule__c.hour() + ' ' + instOfCase.Call_Back_Schedule__c.day() + ' ' + instOfCase.Call_Back_Schedule__c.month() + ' ? ' + instOfCase.Call_Back_Schedule__c.year();
                    String jobID = system.schedule('Call Back Job Manager 1st Level'+instOfCase.CaseNumber, chronExpression, m);
                    
                    intTempMins = instOfCase.Call_Back_Schedule__c.minute() + 30;
                    String chronExpressionSec = '' + instOfCase.Call_Back_Schedule__c.second() + ' ' + intTempMins  + ' ' + instOfCase.Call_Back_Schedule__c.hour() + ' ' + instOfCase.Call_Back_Schedule__c.day() + ' ' + instOfCase.Call_Back_Schedule__c.month() + ' ? ' + instOfCase.Call_Back_Schedule__c.year();
                    String jobIDSec = system.schedule('Call Back Job User'+instOfCase.CaseNumber, chronExpressionSec, mOfUser);
                    
                    intTempMins = instOfCase.Call_Back_Schedule__c.minute() + 60;
                    String chronExpressionThir = '' + instOfCase.Call_Back_Schedule__c.second() + ' ' + intTempMins + ' ' + instOfCase.Call_Back_Schedule__c.hour() + ' ' + instOfCase.Call_Back_Schedule__c.day() + ' ' + instOfCase.Call_Back_Schedule__c.month() + ' ? ' + instOfCase.Call_Back_Schedule__c.year();
                    String jobIDThir = system.schedule('Call Back Job User Manager 2nd Level'+instOfCase.CaseNumber, chronExpressionThir, mSecMan);
                    
                    CaseCallBack__c instOfCCB = new CaseCallBack__c();
                    instOfCCB.Record_Id__c = instOfCase.Id;
                    lstCCB.add(instOfCCB);
                    //instOfCCB.Level_2_Job_Id__c = 
                    //instOfCCB.Level_1_Job_Id__c = 
                }
                Call back functionality for CS*/
            }      
            
            List<Contact> lstContactCPL = new List<Contact>();
            if(setIdOfContact.size()>0)
                lstContactCPL = [SELECT Id,Client_Proficiency_Level__c,(SELECT Id,Client_Proficiency_Level__c FROM Cases WHERE Client_Proficiency_Level__c!=null ORDER By CreatedDate ASC) FROM Contact WHERE Id =: setIdOfContact];
            
            List<Contact> lstContactUpd = new List<Contact>(); 
            for(Contact instCont : lstContactCPL){
                if(instCont.Cases.size()>0){
                    instCont.Client_Proficiency_Level__c =  instCont.Cases[instCont.Cases.size()-1].Client_Proficiency_Level__c;
                    lstContactUpd.add(instCont);
                }
            }
            if(lstContactUpd.size()>0)
                update lstContactUpd;
            //Client Proficieny
            
            //create task for mobile app for apple oid
            
            Id rtID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('New CrowdCompass').getRecordTypeId();
            system.debug('rtID : '+rtID);
            Set<String> oidSet = new Set<String>();
            
                for(Case instOfCase: newMapValues.values()){  
                    if(instOfCase.RecordtypeID == rtID){
                        if(instOfCase.Subject!=null){         
                        if(instOfCase.Subject.length()>0){
                            if(instOfCase.Subject.contains('Ready for Sale')){
                            system.debug('inside for loop : '+instOfCase.Description);
                            if(instOfCase.Description!=null){
                            if(instOfCase.Description.length()>0){
                                Integer result = instOfCase.Description.indexOf('App SKU:');
                                system.debug('result : '+result);
                                if(result>-1){
                                    String temp = instOfCase.Description.substring(result+9,result+22);
                                    system.debug('temp : '+temp);    
                                    oidSet.add(temp);
                                }
                            }}
                        }}    }
                    }
                }
            
                    
            System.debug('oidSet : '+oidSet);
            List<Task> insertTasks = new List<Task>();
            Id rttaskID = Schema.SObjectType.Task.getRecordTypeInfosByName().get('CS CrowdCompass').getRecordTypeId();
            system.debug('rttaskID : '+rttaskID);
            if(oidSet.size()>0){
                for(Mobile_Card__c instofMobCard : [Select id,OwnerId from Mobile_Card__c where Apple_OID__c =: oidSet]){
                    Task t = new Task();
                    t.whatId = instofMobCard.id;
                    t.recordtypeId = rttaskID;
                    t.ownerId = instofMobCard.Ownerid;
                    t.Subject = 'App is ready for use on iTunes - Set it Live on Google';
                    t.ActivityDate = System.Today();
                    t.Priority = 'Normal';
                    insertTasks.add(t);
                }
            }    
            if(insertTasks.size()>0)
                insert insertTasks;
            //create task for mobile app for apple oid
            
            //Contact Priority matrix - Last RM case modified date
            Id casertID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Client Management (Global)').getRecordTypeId();
            system.debug('casertID : '+casertID);
            Set<String> conidSet = new Set<String>();
            for(Case instofCase : newMapValues.values()){
                if(instofCase.ContactID!=null && instofCase.recordtypeid==casertID)
                    conidSet.add(instofCase.ContactID);
            }
            List<Contact> updateCon = new List<Contact>();
            for(Contact instofCon : [Select id, Last_RM_Cases_Activity__c, (Select id,LastModifiedDate from Cases where recordtypeid=:casertID) from Contact where id in: conidSet]){
                List<DateTime> listDT = new List<DateTime>();
                for(Case instofCs : instofCon.Cases){
                    listDT.add(instofCs.LastModifiedDate);
                }
                if(listDT.size()>0){
                    listDT.sort();
                    instofCon.Last_RM_Cases_Activity__c =  listDT[listDT.size()-1];
                    updateCon.add(instofCon);                   
                }
            }
            if(updateCon.size()>0)
               update updateCon; 
            
            //Contact Priority matrix - Last RM case modified date
             Id recTypeId = Schema.SObjectType.Case.RecordTypeInfosByName.get('Sales Ops Team').getRecordTypeId();           
             
            //Approval For Finance 
            for(Case c : newMapValues.values()){
                
                if( ( c.Requestor_Department__c == 'Finance' || c.SuppliedEmail == 'pbhateja@cvent.com' ) && c.RecordTypeId == recTypeId ){
                    SendApprovalForCase(c.Id);
                }
            }
            
            
        }
        
        public void OnBeforeUpdate(Map<Id,Case> oldMapValues,Map<Id,Case> newMapValues){ 
           /* 
            //Variables for Sending an Email
            Set<ID> parentCaseOwnerIds = new Set<ID>();
            Map<ID,String> mapOwnerManagerEmail = new Map<ID,String>();
            Messaging.SingleEmailMessage[] Emailmessages = new List<Messaging.SingleEmailMessage>();
            Id templateId = [Select Id From EmailTemplate Where DeveloperName ='Case_is_Closed_and_Resolved'].Id;
            
            
            Set<String> AppSupportRecordTypes = new Set<String>();          
            Set<ID> parentCaseIds = new Set<ID>();
            Set<Case> ParentCaseToUpdate = new Set<Case> ();
            
            List<Case> allCaseList = [ Select Id ,Parent.OwnerID, OwnerId, Owner.Email,ParentId, Status, RecordType.Name, ( Select Id From Cases Where RecordType.Name like 'App Support%' Limit 1 ) 
                                                   From Case Where ID IN :newMapValues.keySet() ];
            
            // Collecting App Support Case and Putting it's parent Case into Set
            For( Case cCase : allCaseList) {
                
                If(cCase.Cases.size()>0){
                   parentCaseIds.Add(cCase.Id);
                }   
                parentCaseOwnerIds.Add(cCase.Parent.OwnerId);
                
            }
            
            //Map for sending an email to Owner's Manager
            If(parentCaseOwnerIds!=null){
            
            For( User u : [ Select Id,Manager.Email from User Where ID IN: parentCaseOwnerIds] ){            
                        mapOwnerManagerEmail.put(u.Id,u.Manager.Email);
                 }
            }
            
    
            For(Case c : allCaseList){
                //Scenario 1 (Valdation If Escalated Case is being Changed with three fields mentioned below)
                If  ( byPassFcc ==false && newMapValues.get(c.Id).Status == 'Escalated'
                    //If any of these three fields has been changed
                    && (oldMapValues.get(c.Id).Future_Customer_Contact__c != newMapValues.get(c.Id).Future_Customer_Contact__c  
                    || oldMapValues.get(c.Id).Customer_Contacted__c      != newMapValues.get(c.Id).Customer_Contacted__c
                    || oldMapValues.get(c.Id).When_to_contact_the_Customer__c != newMapValues.get(c.Id).When_to_contact_the_Customer__c)
                    //Check If Parent Case has App Support Case
                    && parentCaseIds.contains(c.Id)){
                        Trigger.newMap.Get(c.Id).addError('You cannot schedule a callback to the customer on this case. Kindly create a new case');
                }
                
                // Scenario 2 ( Update Parent Case from App Support Child Case )
                If  ( c.RecordType.Name.containsIgnoreCase('App Support') && c.ParentId != null ){
                    
                      If(  newMapValues.get(c.Id).Status == 'Bug Opened' ){
                
                       Case pCase = new Case();
                       pCase.Id = c.ParentId;
                       pCase.Future_Customer_Contact__c = true;
                       
                       ParentCaseToUpdate.add(pCase);
                       
                      }
                      
                      else if( newMapValues.get(c.Id).Status == 'Closed - Resolved'){
                       
                       Case pCase = new Case();
                       pCase.Id = c.ParentId;
                       pCase.Status = 'Open';
                       
                       ParentCaseToUpdate.add(pCase);  
                       
                       //Email Message once case is closed 
                       
                       If( !String.ValueOf(newMapValues.get(c.Id).OwnerId).startsWithIgnoreCase('00G')){
                       system.debug('************ ID ****  ' + String.ValueOf(newMapValues.get(c.Id).OwnerId));
                       Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                       
                       If(mapOwnerManagerEmail.get(c.Parent.OwnerID)!=null){
                       message.setToAddresses(new string[]{ mapOwnerManagerEmail.get(c.Parent.OwnerID) });
                       }
                       message.settargetObjectId(newMapValues.get(c.Id).OwnerId);
                       message.setTemplateId(templateId);
                       message.setsaveAsActivity(false);
                       Emailmessages.add(message);
                     }
                      
                 }
               }
                
            }
             
             System.Debug('*******  LIST ****** '+ParentCaseToUpdate);
             
             If(ParentCaseToUpdate!=null && ParentCaseToUpdate.size()>0){              
                  Update new List<Case> (ParentCaseToUpdate);
                  byPassFcc = true;
                 

                 //Sending an Email to Case Owner and Manager of Parent Case
                  
                  If(Emailmessages.size()>0)
                  Messaging.sendEmail(Emailmessages);
                  
                }
            */
                      
        }
        public void OnAfterUpdate(Map<Id,Case> oldMapValues,Map<Id,Case> newMapValues){
            //Client Proficieny
            Set<Id> setIdOfContact = new Set<Id>();
            for(Case instOfCase: newMapValues.values()){            
                if(instOfCase.Client_Proficiency_Level__c != oldMapValues.get(instOfCase.Id).Client_Proficiency_Level__c){
                    if(instOfCase.ContactId != null){
                        if(string.valueOf(instOfCase.ContactId).startsWith('003')){
                            setIdOfContact.add(instOfCase.ContactId);
                        }
                    }
                }
            }
            List<Contact> lstContactCPL = new List<Contact>();
            if(setIdOfContact.size()>0)
                lstContactCPL = [SELECT Id,Client_Proficiency_Level__c,(SELECT Id,Client_Proficiency_Level__c FROM Cases WHERE Client_Proficiency_Level__c!=null ORDER By LastModifiedDate) FROM Contact WHERE Id =: setIdOfContact];
            
            List<Contact> lstContactUpd = new List<Contact>(); 
            for(Contact instCont : lstContactCPL){
                if(instCont.Cases.size()>0){
                    instCont.Client_Proficiency_Level__c =  instCont.Cases[instCont.Cases.size()-1].Client_Proficiency_Level__c;
                    lstContactUpd.add(instCont);
                }
            }
            if(lstContactUpd.size()>0)
                update lstContactUpd;
            //Client Proficieny    
            
            //Contact Priority matrix - Last RM case modified date
            Id casertID = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Client Management (Global)').getRecordTypeId();
            system.debug('casertID : '+casertID);
            Set<String> conidSet = new Set<String>();
            for(Case instofCase : newMapValues.values()){
                if(instofCase.ContactID!=null && instofCase.recordtypeid==casertID)
                    conidSet.add(instofCase.ContactID);
            }
            List<Contact> updateCon = new List<Contact>();
            for(Contact instofCon : [Select id, Last_RM_Cases_Activity__c, (Select id,LastModifiedDate from Cases where recordtypeid=:casertID) from Contact where id in: conidSet]){
                List<DateTime> listDT = new List<DateTime>();
                for(Case instofCs : instofCon.Cases){
                    listDT.add(instofCs.LastModifiedDate);
                }
                if(listDT.size()>0){
                    listDT.sort();
                    instofCon.Last_RM_Cases_Activity__c =  listDT[listDT.Size()-1];
                    updateCon.add(instofCon);                   
                }
            }
            if(updateCon.size()>0)
               update updateCon; 
            
            //Contact Priority matrix - Last RM case modified date
            
            
            //Approval For Finance 
            Id recTypeId = Schema.SObjectType.Case.RecordTypeInfosByName.get('Sales Ops Team').getRecordTypeId();
            
            Map<Id,ProcessInstance> existingApprovals = new Map<Id,ProcessInstance>();
            
            For( ProcessInstance p : [ SELECT Id, TargetObjectId FROM ProcessInstance WHERE TargetObjectId IN:newMapValues.values() AND Status = 'Pending']){
                existingApprovals.put( p.TargetObjectId , p );
            }
            
            //Approval For Finance 
            
            for(Case c : newMapValues.values()){
               
                if( c.recordtypeId == recTypeId && existingApprovals.get(c.Id) == null && c.status!='Pending' && oldMapValues.Get(c.Id).Requestor_Department__c <> 'Finance' 
                &&( c.Requestor_Department__c == 'Finance'  || c.SuppliedEmail == 'pbhateja@cvent.com' ) ){
                 
                   SendApprovalForCase(c.Id);
                  
                }     
                
            }
            
        }
        public void OnBeforeDelete(List<Case> oldValues,Map<Id,Case> oldMapValues){    
        }
        public void OnAfterDelete(List<Case> oldValues,Map<Id,Case> oldMapValues){
        }
        public void OnUndelete(List<Case> newValues){
        }
    }