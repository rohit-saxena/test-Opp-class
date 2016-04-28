/*
//////////////////////////////////////
//      @author Abhishek Pandey     //
/////////////////////////////////////
Version :   1.0
Date : 20th June 2014
Description : Inserts, Contact Role for Opportunity with stage name Closed Won on insert and update .
Version :   2.0
Date : 5th Aug 2014
Description : Changes for CSN-MSA Records updation and insertion.
Version :   3.0
Date : 12th Aug 2014
Description : Changes for Bundle Campaigns Records updation and insertion.
Version :   4.0
Date : 21st Aug 2014
Description : To insert multiple opportunity contact roles on the basis of account associated to the opportunity and contacts under which activities are logged beyond 6 months.
Version : 5.0
Date : 24th Nov 2014
Description : (Tract)-Whenever an opportunity with with unique contract number is inserted create two more opportunities with Straight and Milestone Role ups respectively . 
Version : 6.0
Date : 23rd Jan 2015
Description : (Tract)-On updating Opp currency, Children currency should get updated. 
Version : 7.0
Date : 9th Mar 2015
Description : (Tract)-On updating and insert get currency rate, Children currency and curreny rate should get updated. 
Version : 8.0
Date : 17th April 2015
Description : (Tract-Compliance)-Concept to move opps for reviewing.
Version : 9.0
Date : 20th April 2015
Description : Auto movement to tract .
Version : 10.0
Date : 9th July 2015
Description : Adjusting the cancellation amount .
Version : 11.0
Date : 27th July 2015
Description : Changes related to selected opps movement.
Version : 12.0
Date : 31st July 2015
Description : Validation for Tract Opportunity Regarding Rev Rec Rules.
Version 13.0
Date : 10th August 2015
Description : Validation For sending deal year 1  opp first
Version 14.0
Date : 27th August 2015
Description : New TCV creation concept for CSN and DPS types
Version 15.0
Date:2 Sept 2015
Description : Probability updation concept.
Version 16.0
Date:14 Sept 2015
Description : Updating contracts record on any opp. 
Date:03 Dec 2015
Description : Changes to product category for TPP 
Date: 14 Dec 2015
Decsription :  change - new feature set added
Date: 24 Dec 2015       
Description : Clubbed TRACT billing account for CSN
Date: 3 Feb 2016
Description: Feature value null on Feature sets - new code added to avoid null pointer exception if no feature selected in feature set
Version 17.0
Date:10 Mar 2016
Description : Updating according to the field value Set_Cancellation_Status__c
Version 18.0
Date:11 April 2106
Description : For Onsite Product Product Category Changes
*/

public class OpportunityTrgHelperCls {
    
    public  map<String,Decimal> mapIdDeciStraight = new map<String,Decimal>();
    public  map<String,Decimal> mapIdDeciMil = new map<String,Decimal>();
    public  map<Id,Decimal> mapOppIdFeat = new map<Id,Decimal>();
    public  map<String,String> mapStraightCheck = new map<String,String>();
    public  map<String,String> mapMilestoneCheck = new map<String,String>();
    public  String oppNameStr;
    public  List<Opportunity> lstOppTractIns = new List<Opportunity>();
    public  List<Opportunity> lstOppTractInsCSN = new List<Opportunity>();
    public  map<Id,Opportunity> mapOfMasterOpp = new map<Id,Opportunity>();
    public  map<String,List<Opportunity>> mapOfContNumOpp = new map<String,List<Opportunity>>();
    //For CSN
    public  map<Id,Decimal> mapOppIdTotalFeeFTR = new map<Id,Decimal>();
    public  map<Id,Decimal> mapOppIdTotalFeeDGB = new map<Id,Decimal>();
    public  map<Id,Decimal> mapOppIdTotalFeeCSN = new map<Id,Decimal>();
    public  map<Id,Decimal> mapOppIdTotalFeeDPSSLM = new map<Id,Decimal>();
    
    public  map<String,Decimal> mapIdDeciStraightFTR = new map<String,Decimal>();
    public  map<String,Decimal> mapIdDeciStraightDGB = new map<String,Decimal>();
    public  map<String,Decimal> mapIdDeciStraightCSN = new map<String,Decimal>();
    public  map<String,Decimal> mapIdDeciStraightDPSSLM = new map<String,Decimal>();
    
    public  map<String,Decimal> mapDeciTotalYear1CSN = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear2CSN = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear3CSN = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear4CSN = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear5CSN = new map<String,Decimal>();
    
    public  map<String,Decimal> mapDeciTotalYear1DGB = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear2DGB = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear3DGB = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear4DGB = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear5DGB = new map<String,Decimal>();
    
    public  map<String,Decimal> mapDeciTotalYear1FTR = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear2FTR = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear3FTR = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear4FTR = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear5FTR = new map<String,Decimal>();
    
    public  map<String,Decimal> mapDeciTotalYear1DPSSLM = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear2DPSSLM = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear3DPSSLM = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear4DPSSLM = new map<String,Decimal>();
    public  map<String,Decimal> mapDeciTotalYear5DPSSLM = new map<String,Decimal>();
    
    public  map<String,Decimal> mapPriceAdjYear5 = new map<String,Decimal>();
    public  map<String,Decimal> mapPriceAdjYear4 = new map<String,Decimal>();
    public  map<String,Decimal> mapPriceAdjYear3 = new map<String,Decimal>();
    public  map<String,Decimal> mapPriceAdjYear2 = new map<String,Decimal>();
    public  map<String,Decimal> mapPriceAdjYear1 = new map<String,Decimal>();
    
    public  map<String,Decimal> mapCancellYear5 = new map<String,Decimal>();
    public  map<String,Decimal> mapCancellYear4 = new map<String,Decimal>();
    public  map<String,Decimal> mapCancellYear3 = new map<String,Decimal>();
    public  map<String,Decimal> mapCancellYear2 = new map<String,Decimal>();
    public  map<String,Decimal> mapCancellYear1 = new map<String,Decimal>();
    
    public  map<String,Decimal> mapCSNContrTotalRev = new map<String,Decimal>();
    
    public List<Opportunity> lstOppTractUpd = new List<Opportunity>();
    public List<Opportunity> lstOppTractUpdCSN = new List<Opportunity>();
    public List<Opportunity> lstOppTractInsert = new List<Opportunity>();
    public List<Opportunity> lstOppTractdelete = new List<Opportunity>();
    
    public Decimal CancellationAmt = 0; 
    public Decimal maintenanceFee = 0;
    public Decimal usagePackageFee = 0;
    public Decimal Discount = 0;
    public Decimal convenienceFee = 0;
    public Decimal numOfleadP = 0;
    public Decimal numOfEvents = 0;
    public Decimal intPrceAdj = 0;
    public Decimal intContYear1Total = 0;
    public Decimal intContYear2Total = 0;
    public Decimal intContYear3Total = 0;
    public Decimal intContYear4Total = 0;
    public Decimal intContYear5Total = 0;
    public Decimal intLiqYear1Total = 0;
    public Decimal intLiqYear2Total = 0;
    public Decimal intLiqYear3Total = 0;
    public Decimal intLiqYear4Total = 0;
    public Decimal intLiqYear5Total = 0;
    public Decimal cntTotalReview = 0;
    //For CSN
    
    public static map<String,List<String>> mapProdNameRole =  new map<String,List<String>>();
    public static List<String> lstOfRoles =  new List<String>();
    //(Tract)-Whenever an opportunity with with unique contract number is inserted
    public static List<Feature__c> listLFeature = new List<Feature__c>();
    public static map<String,String> mapPickValAssign = new map<String,String>();
    public static map<Integer,String> mapMonth = new map<Integer,String>();
    public static map<String,String> mapLicenceType = new map<String,String>();
    public static map<String,String> mapLicenceTypeDPSSLM = new map<String,String>();
    public static map<String,String> mapFeatureTypeDGB = new map<String,String>();
    public static map<String,String> mapFeatureTypeFTR = new map<String,String>();
    public static map<String,String> mapFeatureTypeNSP = new map<String,String>();
    public static map<String,String> mapFeatureTypeCompSet = new map<String,String>();
    //(Tract)-Whenever an opportunity with with unique contract number is inserted
    
    //New TCV creation concept for CSN and DPS types
    public static map<String,String> mapLicenceTypeCSNFeature = new map<String,String>();
    public static map<String,String> mapLicenceTypeDpsSlmFeature = new map<String,String>();
    //New TCV creation concept for CSN and DPS types
    
    //Probability updation concept.
    public static List<Probability__c> lstprobablity = new List<Probability__c>();
    public static map<String,Decimal> mapStageProdProb = new map<String,Decimal>();
    public static set<String> setStageName = new set<String>();
    //Probability updation concept.
    
    
    static{
        /*List<Product_And_Role__c> listLProdAndRole = Product_And_Role__c.getall().values();
        for(Product_And_Role__c inarOfLProdAndRole : listLProdAndRole){
            if(mapProdNameRole.ContainsKey(inarOfLProdAndRole.Product_Name__c)){
                List<String> lstString =  mapProdNameRole.get(inarOfLProdAndRole.Product_Name__c);
                lstString.add(inarOfLProdAndRole.Roles__c);
                mapProdNameRole.put(inarOfLProdAndRole.Product_Name__c,lstString);
            }else{
                List<String> lstString = new List<String>();
                lstString.add(inarOfLProdAndRole.Roles__c);
                mapProdNameRole.put(inarOfLProdAndRole.Product_Name__c,lstString);
            }
            lstOfRoles.add(inarOfLProdAndRole.Roles__c);
        }*/
        //Probability updation concept.
        lstprobablity = Probability__c.getall().values();
        for(Probability__c instOfProb : lstprobablity){
            if(instOfProb.License_Type__c!= null)
            mapStageProdProb.put((instOfProb.Product__c+instOfProb.StageName__c+instOfProb.License_Type__c).trim(),instOfProb.Probability__c);
            else
            mapStageProdProb.put((instOfProb.Product__c+instOfProb.StageName__c).trim(),instOfProb.Probability__c);
            
            setStageName.add(instOfProb.StageName__c);
        }
        //Probability updation concept.
        //(Tract)-Whenever an opportunity with with unique contract number is inserted
        listLFeature = Feature__c.getall().values();
        for(Feature__c instOfFeature : listLFeature){
            mapPickValAssign.put(instOfFeature.Picklist_Values__c.trim(),instOfFeature.Assignment__c.trim());
        }
        mapMonth.put(1,'Jan');
        mapMonth.put(2,'Feb');
        mapMonth.put(3,'Mar');
        mapMonth.put(4,'Apr');
        mapMonth.put(5,'May');
        mapMonth.put(6,'Jun');
        mapMonth.put(7,'Jul');
        mapMonth.put(8,'Aug');
        mapMonth.put(9,'Sep');
        mapMonth.put(10,'Oct');
        mapMonth.put(11,'Nov');
        mapMonth.put(12,'Dec');
        
        mapLicenceType.put('1 Diamond','CSN');
        mapLicenceType.put('1/2 Diamond','CSN');
        mapLicenceType.put('2 Diamond','CSN');
        mapLicenceType.put('3 Diamond','CSN');
        mapLicenceType.put('4 Diamond','CSN');
        mapLicenceType.put('RFP Showcase','CSN'); 
        mapLicenceType.put('Social Wall','CSN');
        
        mapLicenceTypeDPSSLM.put('Diamond Plus','CSN - DPS_SLM'); 
        mapLicenceTypeDPSSLM.put('Promo Hub - Gold','CSN - DPS_SLM'); 
        mapLicenceTypeDPSSLM.put('Promo Hub - Silver','CSN - DPS_SLM'); 
        mapLicenceTypeDPSSLM.put('Promotion Hub-Gold Subscription','CSN - DPS_SLM'); 
        mapLicenceTypeDPSSLM.put('Promotion Hub-Targeting','CSN - DPS_SLM'); 
        mapLicenceTypeDPSSLM.put('Suggested Ad','CSN - DPS_SLM'); 
        mapLicenceTypeDPSSLM.put('Competitive Market Ad','CSN - DPS_SLM');
        mapLicenceTypeDPSSLM.put('Promo Hub - Gold','CSN - DPS_SLM');
        
        //New TCV creation concept for CSN and DPS types
        mapLicenceTypeCSNFeature.put('Booster-Comp Set','CSN');
        mapLicenceTypeCSNFeature.put('Social Wall','CSN'); // change - new feature set added
        //New TCV creation concept for CSN and DPS types
        
        //New TCV creation concept for CSN and DPS types
        mapLicenceTypeDpsSlmFeature.put('Booster-Comp Set','CSN - DPS_SLM');
        mapLicenceTypeDpsSlmFeature.put('Booster-Need Dates','CSN - DPS_SLM');
        mapLicenceTypeDpsSlmFeature.put('Booster-Cross MMA','CSN - DPS_SLM');
        mapLicenceTypeDpsSlmFeature.put('Competitive Market Ad','CSN - DPS_SLM');
        //New TCV creation concept for CSN and DPS types
        
        mapFeatureTypeDGB.put('CVB Copy Feature','CSN - DGB');
        mapFeatureTypeDGB.put('DG - Creative Services','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Banner Ad','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Banner Ad City Profile','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Billboard Ads','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Brand Page','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Destination Request a Quote','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Featured_Content Ad','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Featured_Directory Listing','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Featured_Promotion','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Featured_Listing in Side Bar','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Customized','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Creative Services','CSN - DGB');
        mapFeatureTypeDGB.put('DG-Banner Ad_City Page','CSN - DGB');
        mapFeatureTypeDGB.put('DG Listing - Video & Image Gallery Spotlight','CSN - DGB');
        mapFeatureTypeDGB.put('DG Listing - Supplier Spotlight','CSN - DGB');
        mapFeatureTypeDGB.put('DG Listing - Promotion','CSN - DGB');
        mapFeatureTypeDGB.put('DG Listing - Premium Listing on Things to Do Page','CSN - DGB');
        mapFeatureTypeDGB.put('DG Listing - Featured Regional Destination, Venue or Service','CSN - DGB');
        mapFeatureTypeDGB.put('DG Listing - Featured Listing on Maps Page','CSN - DGB');
        mapFeatureTypeDGB.put('DG Listing - Featured in Side Bar','CSN - DGB');
        mapFeatureTypeDGB.put('DG Listing - Convention/Conference Center Ultimate Listing','CSN - DGB');
        mapFeatureTypeDGB.put('DG Listing - Convention/Conference Center Spotlight','CSN - DGB');
        mapFeatureTypeDGB.put('DG Listing - Banner Advertisement_Overview Page','CSN - DGB');
        mapFeatureTypeDGB.put('DG Listing - Banner Advertisement_Meetings Page','CSN - DGB');
        
        mapFeatureTypeFTR.put('Supplier Feature-Chain Filter','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Cross Account Visibility','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-CSN API Access','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Custom Proposal','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Envision Analysis Integration','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Escalation Reports','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Meeting Request Form','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Parked Reports','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-RFP Rating','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-RFP Usernames','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature - Training Workshop SLM','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Routing Rules','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature - Online Certificate Registration','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature - Lead Scoring','CSN - FTR');
        
        //New TCV creation concept for CSN and DPS types
        mapFeatureTypeFTR.put('Supplier Feature-Advanced Custom Proposal','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Basic Custom Proposal','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Custom RFP Views','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Enterprise Package','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Professional Package','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Proposal Defaults','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Reporting','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-RFP Assignment','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-RFP Labels','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Training Workshop','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature-Chain Filter','CSN - FTR');
        mapFeatureTypeFTR.put('Supplier Feature - Payment Post Cancellation','CSN - FTR');
        //New TCV creation concept for CSN and DPS types
        
        mapFeatureTypeNSP.put('Blog - Center Stage','CSN - NSP');
        mapFeatureTypeNSP.put('Blog - Encore','CSN - NSP');
        mapFeatureTypeNSP.put('Blog - Finale','CSN - NSP');
        mapFeatureTypeNSP.put('Blog - Headliner','CSN - NSP');
        mapFeatureTypeNSP.put('Blog - Opener','CSN - NSP');
        mapFeatureTypeNSP.put('Blog - Spotlight','CSN - NSP');
        mapFeatureTypeNSP.put('Email Newsletter- Display Ad','CSN - NSP');
        mapFeatureTypeNSP.put('Email Newsletter-Content Promotion','CSN - NSP');
        mapFeatureTypeNSP.put('Email Newsletter-Featured Article','CSN - NSP');
        mapFeatureTypeNSP.put('Email Newsletter-Featured Destination','CSN - NSP');
        mapFeatureTypeNSP.put('Email Newsletter-Featured Supplier','CSN - NSP');
        mapFeatureTypeNSP.put('Email Newsletter-Footer Promotion','CSN - NSP');
        mapFeatureTypeNSP.put('Email Newsletter-Special Edition','CSN - NSP');
        mapFeatureTypeNSP.put('Promotions Hub-Marquee Ad','CSN - NSP');
        mapFeatureTypeNSP.put('Search Screen','CSN - NSP');
        
        
        mapFeatureTypeCompSet.put('RFP Report-Comp Set','CSN - Compset');
        mapFeatureTypeCompSet.put('RFP Report-Venue One Pager','CSN - Compset');
        mapFeatureTypeCompSet.put('Scorecard-Adobe Site Catalyst','CSN - Compset');
        mapFeatureTypeCompSet.put('Scorecard-Consulting Fees','CSN - Compset');
        mapFeatureTypeCompSet.put('Report- Custom Roll Up Report','CSN - Compset');
        mapFeatureTypeCompSet.put('Reports - Analytics','CSN - Compset');
        mapFeatureTypeCompSet.put('RFP Reports - Analytics','CSN - Compset');
        mapFeatureTypeCompSet.put('Reports - RFP Deep Dive Consultation','CSN - Compset');
        mapFeatureTypeCompSet.put('Report-Venue One Pager','CSN - Compset');
        
        //(Tract)-Whenever an opportunity with with unique contract number is inserted
    }
        
    public void OnBeforeInsert(List<Opportunity> newValues){        
        
        Map<Id,Id> mapOppId = new Map<Id,Id>(); 
        Set<Id> setUserId = new Set<Id>();
        map<String,String> mapMSA = new map<String,String>();
        //(Tract)-On updating and insert get currency rate
        List<Date> lstdate = new List<Date>();
        //public static map<Id,String> mapOppIdExRate = new map<Id,String>();
        //(Tract)-On updating and insert get currency rate
        
        for(Opportunity idForOppNew : newValues){
            
            //if(idForOppNew.Contract_Number_New__c != null && idForOppNew.Product__c == 'CSN' && idForOppNew.StageName != 'Tract')
            //idForOppNew.Contract_Number_CSN__c = idForOppNew.Contract_Number_New__c;
            idForOppNew.Send_This_To_Tract__c = true;
            if(idForOppNew.Set_Cancellation_Status__c == '' || idForOppNew.Set_Cancellation_Status__c ==null)
            idForOppNew.Set_Cancellation_Status__c = 'Do not open';
            if(idForOppNew.Contact_Check__c != true){  
                //(Tract)-Whenever an opportunity with with unique contract number is inserted
                system.debug('idForOppNew.Opp_Type_Classification__c++'+idForOppNew.Opp_Type_Classification__c);
                if(idForOppNew.Opp_Type_Classification__c == null){ 
                //(Tract)-Whenever an opportunity with with unique contract number is inserted            
                    if(idForOppNew.Contact_Associated__c==null || idForOppNew.Contact_Role__c=='' || idForOppNew.Contact_Role__c==null){
                        if(!Test.isRunningTest()){ 
                            idForOppNew.addError('Please specify a contact with role on fields highlighted below');
                            idForOppNew.Contact_Associated__c.addError('Contact');
                            idForOppNew.Contact_Role__c.addError('Contact Role');
                        }                                       
                    }else{
                        idForOppNew.Product_Category__c = null;
                        //(Tract)-On updating and insert get currency rate
                        
                        if(idForOppNew.CloseDate != null && idForOppNew.CloseDate < system.today() && idForOppNew.CurrencyIsoCode != 'USD'){
                            lstdate.add(idForOppNew.CloseDate);
                        }else if(idForOppNew.CloseDate >= system.today() && idForOppNew.CurrencyIsoCode != 'USD'){
                            //mapOppIdExRate.put(idForOppNew.Id,idForOppNew.CurrencyIsoCode);
                        }else if(idForOppNew.CurrencyIsoCode == 'USD'){
                            idForOppNew.Exchange_Rate__c = 1;
                        }
                        //(Tract)-On updating and insert get currency rate
                        
                        //if(idForOppNew.License_Type__c != null){
                        //    if(mapLicenceType.containsKey(idForOppNew.License_Type__c.trim()))
                        //    idForOppNew.Product_Category__c = mapLicenceType.get(idForOppNew.License_Type__c.trim());
                        //}
                        
                        if(idForOppNew.Product__c =='CrowdCompass' && idForOppNew.Deal_Booked_In__c =='US Books')
                        idForOppNew.Product_Category__c = 'CrowdCompass';
                        
                        if(idForOppNew.Product__c =='CrowdCompass' && idForOppNew.Deal_Booked_In__c =='UK Books')
                        idForOppNew.Product_Category__c = 'CrowdCompass - UK';
                        
                        if(idForOppNew.Product__c =='Event' && (idForOppNew.Team__c=='BD' || idForOppNew.Team__c=='Product Adoption' || idForOppNew.Team__c=='Ecommerce/CS')){
                            idForOppNew.Product_Category__c = 'Event';
                        }else{
                            if(idForOppNew.Product__c !='CrowdCompass' && (idForOppNew.Deal_Booked_In__c !='UK Books' || idForOppNew.Deal_Booked_In__c !='US Books' ))
                            idForOppNew.Product_Category__c = idForOppNew.Product__c;
                        }
                        
                        if(idForOppNew.Product__c =='Event' && (idForOppNew.Product_Category__c == null || idForOppNew.Product_Category__c ==''))
                        setUserId.add(idForOppNew.OwnerId);
                        
                        //For Onsite Product
                        if(idForOppNew.Product__c =='Onsite Solutions' && idForOppNew.Team__c =='Enterprise')
                        idForOppNew.Product_Category__c ='Enterprise';
                        else if(idForOppNew.Product__c == 'Onsite Solutions' && idForOppNew.Team__c !='Enterprise')
                        idForOppNew.Product_Category__c ='Event';
                        //For Onsite Product
                        
                        //mapOppId.put(idForOppNew.id,idForOppNew.id);
                        
                        //Probability updation concept.
                        system.debug(idForOppNew.License_Type__c);
                        system.debug(idForOppNew.NBB_Renewal__c);
                        system.debug(idForOppNew.Parent_Upsell__c);
                        system.debug(idForOppNew.License_Type__c);
                        
                        system.debug(mapStageProdProb);
                        if(idForOppNew.License_Type__c!=null){
                            if(!idForOppNew.License_Type__c.contains('Diamond') && idForOppNew.NBB_Renewal__c == 'Renewal' && idForOppNew.Parent_Upsell__c == 'Primary' && setStageName.contains(idForOppNew.StageName)){
                                String str = idForOppNew.Product__c + idForOppNew.StageName;
                                idForOppNew.Probabilities__c = mapStageProdProb.get(str);
                            }else if(idForOppNew.NBB_Renewal__c == 'Renewal' && idForOppNew.Parent_Upsell__c == 'Primary' && setStageName.contains(idForOppNew.StageName)){
                                String Str = idForOppNew.Product__c + idForOppNew.StageName + 'Diamond';
                                idForOppNew.Probabilities__c = mapStageProdProb.get(str);
                            }else if( idForOppNew.NBB_Renewal__c != 'Renewal' || idForOppNew.Parent_Upsell__c != 'Primary'|| (!setStageName.contains(idForOppNew.StageName))){
                                //(idForOppNew.StageName != 'Positive Response to Renewal' && idForOppNew.StageName != 'At Risk' && idForOppNew.StageName != 'Up for Renewal'  && idForOppNew.StageName != 'Verbal') ||
                                system.debug(idForOppNew.Probability);
                                idForOppNew.Probabilities__c = idForOppNew.Probability;
                                system.debug(idForOppNew.Probabilities__c);
                            }
                        }
                        //Probability updation concept.
                    }
                    if(idForOppNew.MSA_Code__c != null)
                    mapMSA.put(idForOppNew.MSA_Code__c,idForOppNew.MSA_Code__c);
                //(Tract)-Whenever an opportunity with with unique contract number is inserted     
                }    
                //(Tract)-Whenever an opportunity with with unique contract number is inserted           
            }                   
        }
        //(Tract)-Whenever an opportunity with with unique contract number is inserted
        //map<Id,Opportunity> mapOpp = new map<Id,Opportunity>();
        //if(mapOppId.keySet().size()>0)
        //mapOpp = new map<ID,Opportunity>([SELECT Id,(SELECT Id,Feature__c FROM R00N00000008aGEXEA2) FROM Opportunity WHERE Id =: mapOppId.keySet()]);
        
        //(Tract)-On updating and insert get currency rate
        List<DatedConversionRate> lstDateCR =  [SELECT StartDate, IsoCode, ConversionRate FROM DatedConversionRate WHERE (StartDate =: lstDate OR StartDate =: system.Today().adddays(-1))];
        
        map<String,Decimal> mapConv =  new map<String,Decimal>();
        map<String,Decimal> mapConvTodayOrMore =  new map<String,Decimal>();
        for(DatedConversionRate isntOfDCR : lstDateCR){
            system.debug('isntOfDCR.StartDate+++'+isntOfDCR.StartDate);
            system.debug('system.today()+++'+system.today());
            //if(isntOfDCR.StartDate == system.today().adddays(-1)){
                mapConv.put(isntOfDCR.StartDate + isntOfDCR.IsoCode,isntOfDCR.ConversionRate);
            //}
            if(isntOfDCR.StartDate == system.today().adddays(-1)){
                mapConvTodayOrMore.put(isntOfDCR.StartDate + isntOfDCR.IsoCode,isntOfDCR.ConversionRate);
            }
        }
        
        //(Tract)-On updating and insert get currency rate
        
        map<Id,User> mapUser = new map<Id,User>();
        if(setUserId.Size()>0)
        mapUser = new map<Id,User>([SELECT Id,UserRole.Name FROM User WHERE Id =: setUserId]);
        
        //(Tract)-Whenever an opportunity with with unique contract number is inserted
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded
        // Changes for CSN-MSA Records updation and insertion.
        
        List<Multi_Property_Bundles__c> lstCSNMSA = new List<Multi_Property_Bundles__c>();
        
        if(mapMSA.keyset().size() > 0)
        lstCSNMSA =  [SELECT Id,MSA_Code__c FROM  Multi_Property_Bundles__c WHERE MSA_Code__c != null AND MSA_Code__c =: mapMSA.keyset()];
        
        Map<String,Id> mapCSNMSA = new Map<String,Id>();
        
        for(Multi_Property_Bundles__c instOfCSNMSA : lstCSNMSA){
            mapCSNMSA.put(instOfCSNMSA.MSA_Code__c.trim(),instOfCSNMSA.Id);                    
        }       
        
        system.debug('mapCSNMSA++'+mapCSNMSA);
        system.debug('mapOppId+++'+mapOppId);
        Integer counter =0;
        Integer counterSec = 0;
        for(Opportunity idForOppNew : newValues){
            if(mapCSNMSA.ContainsKey(idForOppNew.MSA_Code__c)){
                idForOppNew.Bundle_Campaigns__c = mapCSNMSA.get(idForOppNew.MSA_Code__c.trim());
                system.debug('+++---'+idForOppNew.Bundle_Campaigns__c);
            }   
            
            //(Tract)-On updating and insert get currency rate
            
            String strDateIso = idForOppNew.CloseDate + idForOppNew.CurrencyIsoCode;
            if(mapConv.containsKey(strDateIso)){
                idForOppNew.Exchange_Rate__c = mapConv.get(strDateIso);
            }
            
            if(idForOppNew.CloseDate >= system.today()){
                for(String strDateCurr : mapConvTodayOrMore.KeySet()){
                    if(strDateCurr.contains(idForOppNew.CurrencyIsoCode)){
                        idForOppNew.Exchange_Rate__c = mapConvTodayOrMore.get(strDateCurr);
                    }
                }
            }
            
            //(Tract)-On updating and insert get currency rate
            /*if(mapOpp.containsKey(idForOppNew.Id)){
                counter = 0;
                counterSec = 0;
                Opportunity instOfOpp = mapOpp.get(idForOppNew.Id);
                for(Feature_Set__c instOfFeature : instOfOpp.R00N00000008aGEXEA2){
                    if(mapFeatureType.containsKey(instOfFeature.Feature__c.trim()))
                    counter++;
                }
                for(Feature_Set__c instOfFeature : instOfOpp.R00N00000008aGEXEA2){
                    if(mapFeatureTypeFTR.containsKey(instOfFeature.Feature__c.trim()))
                    counterSec++;
                }
                if(counter > 0)
                idForOppNew.Product_Category__c = mapFeatureType.values()[0];
                
                if(counterSec > 0)
                idForOppNew.Product_Category__c = mapFeatureTypeFTR.values()[0];
            }   
            */
            
            //(Tract)-On updating and insert get currency rate
            
            //(Tract)-On updating and insert get currency rate
            if(idForOppNew.Product__c == 'Event'){
                if(mapUser.containsKey(idForOppNew.OwnerId)){
                    User instOfUsr = mapUser.get(idForOppNew.OwnerId);
                    if(instOfUsr.UserRole.Name.contains('Event'))
                    idForOppNew.Product_Category__c = 'Event';
                    
                    if(instOfUsr.UserRole.Name.contains('(Ent)'))
                    idForOppNew.Product_Category__c = 'Enterprise';
                    
                    if(instOfUsr.UserRole.Name.contains('(TPP)'))
                    // Changes to product category for TPP
                    //idForOppNew.Product_Category__c = 'TPP';  - earlier code commented
                    idForOppNew.Product_Category__c = 'Event';
                    //Changes to product category for TPP
                }
                
            }
                
        }
        // Changes for CSN-MSA Records updation and insertion.
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded
    }
    public void OnAfterInsert(Map<Id,Opportunity> newMapValues){
        //To insert multiple opportunity contact roles
        List<Id> lstAccId = new List<Id>();
        //Map<Id,String> mapAccIdProd = new Map<Id,String>();
        //Map<Id,Id> mapAccIdOppId =  new Map<Id,Id>();
        Map<String,OpportunityContactRole> mapOppContRole = new Map<String,OpportunityContactRole>();
        //To insert multiple opportunity contact roles
        
        //(Tract-Compliance)-Concept to move opps for reviewing.
        //List<Contract_Reviewing__c> lstContRev = new List<Contract_Reviewing__c>();
        //(Tract-Compliance)-Concept to move opps for reviewing.
        
        List<OpportunityContactRole> lstOppContactRole = new List<OpportunityContactRole>();
        
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded
        List<Id> lstBundleCampId = new List<Id>();
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded
        
        for(Opportunity idForOppNew : newMapValues.values()){
            if(idForOppNew.Contact_Check__c != true && idForOppNew.Contact_Associated__c !=null && (idForOppNew.Contact_Role__c != '' && idForOppNew.Contact_Role__c != null)){ 
                OpportunityContactRole instOppContactRole = new OpportunityContactRole();
                instOppContactRole.OpportunityId =  idForOppNew.Id;                 
                instOppContactRole.ContactId = idForOppNew.Contact_Associated__c;       
                instOppContactRole.Role = idForOppNew.Contact_Role__c;                  
                instOppContactRole.IsPrimary =  true;
                //To insert multiple opportunity contact roles
                /*system.debug('idForOppNew.Id+++'+idForOppNew.Id);
                system.debug('idForOppNew.Contact_Role__c+++'+idForOppNew.Contact_Associated__c);
                String oppIdAndContId = String.valueOf(idForOppNew.Id)+String.valueOf(idForOppNew.Contact_Associated__c);
                system.debug('oppIdAndContId+++'+oppIdAndContId);
                mapOppContRole.put(oppIdAndContId,instOppContactRole);*/
                //To insert multiple opportunity contact roles
                lstOppContactRole.add(instOppContactRole);
            }
            
            
            //(Tract-Compliance)-Concept to move opps for reviewing.
            //if(idForOppNew.StageName == 'Tract'){
                //Contract_Reviewing__c instOfContRev = new Contract_Reviewing__c();
                //instOfContRev.Opportunity__c = idForOppNew.Id;
                //lstContRev.add(instOfContRev);
            //}
            //(Tract-Compliance)-Concept to move opps for reviewing.
            
            // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded//Rollup Code On Insertion
            if(idForOppNew.Bundle_Campaigns__c != null)
            lstBundleCampId.add(idForOppNew.Bundle_Campaigns__c);       
            // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded//Rollup Code On Insertion
            
            //To insert multiple opportunity contact roles
            /*if(idForOppNew.AccountId != null && idForOppNew.Product__c != null && idForOppNew.Product__c != '' ){
                lstAccId.add(idForOppNew.AccountId);//Takes out the account associated
                //mapAccIdProd.put(idForOppNew.AccountId,idForOppNew.Product__c);
                //mapAccIdOppId.put(idForOppNew.AccountId,idForOppNew.Id);
            }*/
            //To insert multiple opportunity contact roles              
        }
        //(Tract-Compliance)-Concept to move opps for reviewing.
        //if(lstContRev.size()>0)
        //insert lstContRev;
        //(Tract-Compliance)-Concept to move opps for reviewing.
        system.debug('lstOppContactRole++++'+lstOppContactRole);
        system.debug('lstAccId++++'+lstAccId);
        
        if(lstOppContactRole.size()>0)
        insert lstOppContactRole;
        //To insert multiple opportunity contact roles
        /*
        List<Account> lstAccCons = new List<Account>();
        if(lstAccId.size()>0)
        lstAccCons = [SELECT Id,(SELECT Id FROM Contacts) FROM Account WHERE Id =: lstAccId]; 
        
        system.debug('lstAccCons++++'+lstAccCons);
        
        //Map<Id,Account> mapContIdAccount = new Map<Id,Account>(); 
        List<Id> lstContactIds =  new List<Id>();
        for(Account instOfAcc : lstAccCons){
            for(Contact instOfCon : instOfAcc.Contacts){
                lstContactIds.add(instOfCon.Id);//Takes out the contacts associated with all accounts
                //mapContIdAccount.put(instOfCon.Id,instOfAcc);
            }
        }
        
        system.debug('lstContactIds++++'+lstContactIds);
        system.debug('lstOfRoles++'+lstOfRoles);
        List<Contact> lstContTsk = new List<Contact>();
        if(lstContactIds.size()>0)
        lstContTsk = [SELECT Id,(SELECT Id,ActivityDate,Owner.UserRole.Name FROM Tasks WHERE Owner.UserRole.Name =: lstOfRoles And IsClosed=true) FROM Contact WHERE Id =: lstContactIds];
        
        system.debug('lstContTsk+++'+lstContTsk);
        
        Map<Id,List<Task>> mapContIdTsk = new Map<Id,List<Task>>();
        Integer intDateDiff = 0;
        for(Contact instOfCont : lstContTsk){
            system.debug('instOfCont.Tasks+++++'+instOfCont.Tasks);
            List<Task> lstOfTask = new List<Task>();
            intDateDiff = 0;
            if(instOfCont.Tasks.size()>0){
                intDateDiff = 0;
                for(Task instOfTsk : instOfCont.Tasks){
                    intDateDiff = instOfTsk.ActivityDate.daysBetween(system.Today());
                    system.debug('intDateDiff+++++'+intDateDiff);
                    if(intDateDiff <= 185){
                        lstOfTask.add(instOfTsk);
                    }
                }
            }
            if(lstOfTask.size()>0)
            mapContIdTsk.put(instOfCont.Id,lstOfTask);//Takes out all the tasks which have Activity date in last 185 days with respective contact
        }
        
        
        system.debug('mapContIdTsk++++'+mapContIdTsk);
        
        Map<Id,List<ID>> mapAccIdLstCont = new Map<Id,List<Id>>();
        
        for(Account instOfAcc : lstAccCons){
            for(Contact instOfContSec : instOfAcc.Contacts){
                for(Id instOfContId : mapContIdTsk.keySet()){
                    if(instOfContSec.Id == instOfContId){
                        if(mapAccIdLstCont.ContainsKey(instOfAcc.Id)){
                            List<Id> lstCont =  mapAccIdLstCont.get(instOfAcc.Id);
                            lstCont.add(instOfContId);
                            mapAccIdLstCont.put(instOfAcc.Id,lstCont);
                        }else{
                            List<Id> lstCont = new List<Id>();
                            lstCont.add(instOfContId);
                            mapAccIdLstCont.put(instOfAcc.Id,lstCont);
                        }
                    }   
                }   
            }
        }
        for(Account instOfAcc : lstAccCons){
            for(Contact instOfContSec : instOfAcc.Contacts){
                if(mapContIdTsk.ContainsKey(instOfContSec.Id)){
                    if(mapAccIdLstCont.ContainsKey(instOfAcc.Id)){
                        List<Id> lstCont =  mapAccIdLstCont.get(instOfAcc.Id);
                        lstCont.add(instOfContSec.Id);
                        mapAccIdLstCont.put(instOfAcc.Id,lstCont);
                    }else{
                        List<Id> lstCont = new List<Id>();
                        lstCont.add(instOfContSec.Id);
                        mapAccIdLstCont.put(instOfAcc.Id,lstCont);//Map for having Accounts and with respective contact that might get associated with Opp
                    }
                }
            }
        }
        system.debug('mapAccIdLstCont++++'+mapAccIdLstCont);
        //map<Id,List<Id>> mapAccIdListCont = new map<Id,List<ID>>();
        //List<OpportunityContactRole> lstOppContactRoleSec = new List<OpportunityContactRole>();
        
        for(Opportunity idForOppNew : newMapValues.values()){
            if(idForOppNew.AccountId != null){
                List<String> lstRoles = mapProdNameRole.get(idForOppNew.Product__c);
                List<Id> lstContIds = new List<Id>();
                Integer counterSec = 0;
                try{
                    lstContIds = mapAccIdLstCont.get(idForOppNew.AccountId);
                    for(Id instOfContId : lstContIds){
                        
                    }
                }catch(exception e){
                    system.debug(e);
                    counterSec++;
                }   
                if(counterSec == 0){
                    for(Id instOfContId : lstContIds){
                        List<Task> lstTasks = mapContIdTsk.get(instOfContId);
                        Integer Counter=0;
                        for(Task instOfTask : lstTasks){
                            for(String instOfRole : lstRoles){
                                system.debug('instOfTask.Owner.UserRole.Name++++'+instOfTask.Owner.UserRole.Name);
                                system.debug('instOfRole++++'+instOfRole);
                                if(instOfTask.Owner.UserRole.Name == instOfRole){
                                    Counter++;
                                }
                            }
                        }
                        if(Counter>0){
                            system.debug('idForOppNew.Id+++'+idForOppNew.Id);
                            system.debug('instOfContId+++'+instOfContId);
                            String oppIdAndContId = String.valueOf(idForOppNew.Id)+ String.valueOf(instOfContId);
                            system.debug('oppIdAndContId+++'+oppIdAndContId);
                            system.debug('mapOppContRole+++'+mapOppContRole);
                            if(!mapOppContRole.containsKey(oppIdAndContId)){
                                OpportunityContactRole instOppContactRole = new OpportunityContactRole();
                                instOppContactRole.OpportunityId = idForOppNew.Id;                 
                                instOppContactRole.ContactId = instOfContId;       
                                lstOppContactRole.add(instOppContactRole);
                                mapOppContRole.put(oppIdAndContId,instOppContactRole);
                            }
                        }
                    }   
                }
            }
        }
        system.debug('lstOppContactRole++++'+lstOppContactRole);
        system.debug('mapOppContRole+++'+mapOppContRole);
        if(mapOppContRole.values().size()>0)
        insert mapOppContRole.values();*/
        //lstOppContactRole.addall(lstOppContactRoleSec);
        //To insert multiple opportunity contact roles  
        
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded//Rollup Code On Insertion
        List<Multi_Property_Bundles__c> lstMultiPropBund = new List<Multi_Property_Bundles__c>();
        
        if(lstBundleCampId.size()>0)
        lstMultiPropBund =  [SELECT Id,MSA_Total__c,(SELECT ID,New_Contract_Total__c FROM Opportunities_Bund__r) FROM Multi_Property_Bundles__c WHERE Id =: lstBundleCampId];   
            
        List<Multi_Property_Bundles__c> lstMultiPropBundSec = new List<Multi_Property_Bundles__c>();
        
        for(Multi_Property_Bundles__c instOfMutiPropBund : lstMultiPropBund){
            Decimal intContractTot=0;
            for(Opportunity instOfOpp : instOfMutiPropBund.Opportunities_Bund__r){
                intContractTot = intContractTot + instOfOpp.New_Contract_Total__c;
            }
            instOfMutiPropBund.MSA_Total__c = String.valueOf(intContractTot);
            lstMultiPropBundSec.add(instOfMutiPropBund);
        }       
        
        if(lstMultiPropBundSec.size()>0){
            update lstMultiPropBundSec;
        }
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded//Rollup Code On Insertion
                                             
    }
    public void OnBeforeUpdate(Map<Id,Opportunity> oldMapValues,Map<Id,Opportunity> newMapValues){ 
        //(Tract)-Whenever an opportunity with with unique contract number is inserted
        Map<Id,Id> mapOppId = new Map<Id,Id>(); 
        Set<Id> setUserId = new Set<Id>();
        //(Tract)-Whenever an opportunity with with unique contract number is inserted
        
        List<Opportunity> lstOpp = new List<Opportunity>();
        List<Opportunity> lstOppForError =  new List<Opportunity>();
        
        //(Tract)-On updating and insert get currency rate
        List<Date> lstdate = new List<Date>();
        //map<Id,Decimal> mapOppIdExRate = new map<Id,Decimal>();
        //(Tract)-On updating and insert get currency rate
        
        //Validation For sending deal year 1  opp first
        /*List<String> lstStrContrNo = new List<String>();
        map<String,List<String>> mapContrNum = new map<String,List<String>>();
        List<String> lstAccIds = new List<String>();*/
        //Validation For sending deal year 1  opp first
        
        for(Opportunity idForOppNew : newMapValues.values()){
            //if(idForOppNew.Tract_Sales_Order__c != null && idForOppNew.Tract_Sales_Order__c != ''&& oldMapValues.get(idForOppNew.Id).Tract_Sales_Order__c != null && oldMapValues.get(idForOppNew.Id).Tract_Sales_Order__c!=''){
                //system.debug('Debug++++'+'Error');
                //idForOppNew.addError('This record cannot be updated as it has moved to Tract');
            //}
            if(newMapValues.get(idForOppNew.Id).CurrencyIsoCode != oldMapValues.get(idForOppNew.Id).CurrencyIsoCode || newMapValues.get(idForOppNew.Id).CloseDate != oldMapValues.get(idForOppNew.Id).CloseDate){
                if(idForOppNew.CloseDate != null && idForOppNew.CloseDate < system.today() && idForOppNew.CurrencyIsoCode != 'USD'){
                    lstdate.add(idForOppNew.CloseDate);
                }else if(idForOppNew.CloseDate >= system.today() && idForOppNew.CurrencyIsoCode != 'USD'){
                    //mapOppIdExRate.put(idForOppNew.Id,idForOppNew.CurrencyIsoCode);
                }else if(idForOppNew.CurrencyIsoCode == 'USD'){
                    idForOppNew.Exchange_Rate__c = 1;
                }   
            }
            //if(idForOppNew.Contract_Number_New__c != null && idForOppNew.Product__c == 'CSN' && idForOppNew.StageName != 'Tract')
            //idForOppNew.Contract_Number_CSN__c = idForOppNew.Contract_Number_New__c;
            
            //for(Opportunity idForOppOld : oldMapValues.values()){
                //if(idForOppNew.Id==idForOppOld.Id){
                    //system.debug('wwwwwwwwwwwwwwwwwww+'+newMapValues.get(idForOppNew.id).Contact_Associated__c);
                    //system.debug('wwwwwwwwwwwwwwwwwww+'+newMapValues.get(idForOppOld.id).Contact_Role__c);
                    if(newMapValues.get(idForOppNew.id).StageName=='Closed Won' && oldMapValues.get(idForOppNew.id).StageName!='Closed Won'){
                        if(idForOppNew.Contact_Associated__c != null && idForOppNew.Contact_Role__c != null){
                            lstOpp.add(idForOppNew);
                        }else if(idForOppNew.Contact_Associated__c == null || idForOppNew.Contact_Role__c=='' || idForOppNew.Contact_Role__c== null){
                            lstOppForError.add(idForOppNew);
                        }
                    }
            //Updating according to the field value Set_Cancellation_Status__c
            if(idForOppNew.Set_Cancellation_Status__c != oldMapValues.get(idForOppNew.Id).Set_Cancellation_Status__c){
                if(idForOppNew.Set_Cancellation_Status__c == 'Edit Only'){
                    idForOppNew.IsLocked__c = false;
                    //lstUpdatePicklistCancel.add(idForOppNew);
                }else if(idForOppNew.Set_Cancellation_Status__c == 'Edit and Remove TRACT Order #'){
                    idForOppNew.IsLocked__c = false;
                    idForOppNew.TRACT_Order_Old__c = idForOppNew.TRACT2__Tract_Sales_Order__c;
                    idForOppNew.TRACT2__Tract_Sales_Order__c = '';
                    //lstUpdatePicklistCancel.add(idForOppNew);
                }else if(idForOppNew.Set_Cancellation_Status__c == 'Edit & Clone'){
                    idForOppNew.IsLocked__c = false;
                    //lstUpdatePicklistCancel.add(idForOppNew);
                    //lstUpdatePicklistInsertIds.add(idForOppNew.Id);
                    /*
                    Opportunity instOppNewIns = new Opportunity();
                    instOppNewIns.Tract_Billing_Account_Number__c = '';
                    instOppNewIns.Contract_Implemented__c = false;
                    instOppNewIns.Contract_Implemented_by__c = '';
                    instOppNewIns.Clubbed_Tract_Billing_Account__c = '';*/
                }else if(idForOppNew.Set_Cancellation_Status__c == 'Do not open'){
                    idForOppNew.IsLocked__c = true;
                    //lstUpdatePicklistCancel.add(idForOppNew);
                }
            }
            //Updating according to the field value Set_Cancellation_Status__c
                     
            //Validation For sending deal year 1  opp first
            /*if((idForOppNew.Re_Reviewed_by__c !=null && idForOppNew.Re_Reviewed_by__c!= '' && oldMapValues.get(idForOppNew.Id).Re_Reviewed_by__c != idForOppNew.Re_Reviewed_by__c)||(idForOppNew.CFC_Check__c != null && idForOppNew.CFC_Check__c !='' && oldMapValues.get(idForOppNew.Id).CFC_Check__c != idForOppNew.CFC_Check__c) ){
                lstStrContrNo.add(idForOppNew.Contract_Number_New__c);
                lstAccIds.add(idForOppNew.AccountId);
                if(mapContrNum.containsKey(idForOppNew.Contract_Number_New__c)){
                    List<String> lstStrYear = mapContrNum.get(idForOppNew.Contract_Number_New__c);
                    lstStrYear.add(idForOppNew.Deal_Year__c);
                    mapContrNum.put(idForOppNew.Contract_Number_New__c,lstStrYear);
                }else{
                    List<String> lstStrYear = new List<String>();
                    lstStrYear.add(idForOppNew.Deal_Year__c);
                    mapContrNum.put(idForOppNew.Contract_Number_New__c,lstStrYear);
                }
            }*/
            //Validation For sending deal year 1  opp first
            
            //Probability updation concept.
            system.debug(idForOppNew.License_Type__c);
            system.debug(idForOppNew.NBB_Renewal__c);
            system.debug(idForOppNew.Parent_Upsell__c);
            
            system.debug(mapStageProdProb);
            //if(idForOppNew.License_Type__c != oldMapValues.get(idForOppNew.Id).License_Type__c || idForOppNew.NBB_Renewal__c != oldMapValues.get(idForOppNew.Id).NBB_Renewal__c || idForOppNew.Parent_Upsell__c != oldMapValues.get(idForOppNew.Id).Parent_Upsell__c || idForOppNew.StageName != oldMapValues.get(idForOppNew.Id).StageName){
            if(idForOppNew.License_Type__c!=null){
                if(!idForOppNew.License_Type__c.contains('Diamond') && idForOppNew.NBB_Renewal__c == 'Renewal' && idForOppNew.Parent_Upsell__c == 'Primary' && setStageName.contains(idForOppNew.StageName)){
                    String str = idForOppNew.Product__c + idForOppNew.StageName;
                    idForOppNew.Probabilities__c = mapStageProdProb.get(str);
                }else if(idForOppNew.NBB_Renewal__c == 'Renewal' && idForOppNew.Parent_Upsell__c == 'Primary' && setStageName.contains(idForOppNew.StageName)){
                    String Str = idForOppNew.Product__c + idForOppNew.StageName + 'Diamond';
                    idForOppNew.Probabilities__c = mapStageProdProb.get(str);
                }else if( idForOppNew.NBB_Renewal__c != 'Renewal' || idForOppNew.Parent_Upsell__c != 'Primary'|| (!setStageName.contains(idForOppNew.StageName))){
                    //(idForOppNew.StageName != 'Positive Response to Renewal' && idForOppNew.StageName != 'At Risk' && idForOppNew.StageName != 'Up for Renewal'  && idForOppNew.StageName != 'Verbal') ||
                    system.debug(idForOppNew.Probability);
                    idForOppNew.Probabilities__c = idForOppNew.Probability;
                    system.debug(idForOppNew.Probabilities__c);
                }
            }
            //}
            //Probability updation concept.
            
            //Adjusting the cancellation amount 
            if((idForOppNew.Counted_sales_Cancellation_Value__c != oldMapValues.get(idForOppNew.Id).Counted_sales_Cancellation_Value__c && idForOppNew.Counted_sales_Cancellation_Value__c !=null) || (idForOppNew.Counted_sales_Cancellation_Value__c != oldMapValues.get(idForOppNew.Id).Counted_sales_Cancellation_Value__c && idForOppNew.Counted_sales_Cancellation_Value__c !=null)){
                idForOppNew.Cancellation_Date_Tract__c = system.today();
            }else if(idForOppNew.Counted_sales_Cancellation_Value__c != oldMapValues.get(idForOppNew.Id).Counted_sales_Cancellation_Value__c && idForOppNew.Counted_sales_Cancellation_Value__c ==null){
                idForOppNew.Cancellation_Date_Tract__c = null;
            }
            //Adjusting the cancellation amount 
            
            //Validation for Tract Opportunity Regarding Rev Rec Rules.
            if((idForOppNew.Contract_Type_Rev_Rec__c == 'One Contract Total Value for Revenue Recognition' ||idForOppNew.Contract_Type_Rev_Rec__c =='Disproportionate annualized contract Value for respective years') ){
                if(idForOppNew.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c!=null || idForOppNew.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c!=null || idForOppNew.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c!=null || idForOppNew.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c!=null || idForOppNew.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c!=null){
                    idForOppNew.addError('Revenue Rule inputted in incorrect field. Please rectify');   
                }else if(idForOppNew.Rev_Rec_Rule_Assigned__c == null){
                    idForOppNew.addError('Revenue Rule inputted in incorrect field. Please rectify');   
                }
                
            }else if(idForOppNew.Contract_Type_Rev_Rec__c =='Separate Contract Value for each year for Revenue Recognition'){
                if((idForOppNew.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c==null && idForOppNew.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c==null && idForOppNew.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c==null && idForOppNew.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c==null && idForOppNew.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c==null )||idForOppNew.Rev_Rec_Rule_Assigned__c !=null){
                    idForOppNew.addError('Revenue Rule inputted in incorrect field. Please rectify');   
                }
            }
            /*if(idForOppNew.Rev_Rec_Rule_Assigned__c !=null && (idForOppNew.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c!=null || idForOppNew.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c!=null || idForOppNew.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c!=null || idForOppNew.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c!=null || idForOppNew.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c!=null ) ){
                idForOppNew.addError('You cannot put values in Rev Rec Rule for whole TCV and in annual Opportunity(s) simultaneously');
            }*/
            //Validation for Tract Opportunity Regarding Rev Rec Rules.
                //}
            //}
            //(Tract)-Whenever an opportunity with with unique contract number is inserted
            // Changes to product category for TPP 
            if(idForOppNew.Product_Category__c != 'TPP') // new line added to make sure if TPP is changed manually it is not reverted back.
                idForOppNew.Product_Category__c = null;
            // Changes to product category for TPP 
            //if(idForOppNew.License_Type__c!=null){
            //    if(mapLicenceType.containsKey(idForOppNew.License_Type__c.trim()))
            //    idForOppNew.Product_Category__c = mapLicenceType.get(idForOppNew.License_Type__c.trim());
            //}
            
            if(idForOppNew.Product__c != null && idForOppNew.Deal_Booked_In__c!= null){
                if(idForOppNew.Product__c =='CrowdCompass' && idForOppNew.Deal_Booked_In__c =='US Books')
                idForOppNew.Product_Category__c = 'CrowdCompass';
            }
            system.debug(idForOppNew.Product_Category__c);
            
            if(idForOppNew.Product__c =='CrowdCompass' && idForOppNew.Deal_Booked_In__c =='UK Books')
            idForOppNew.Product_Category__c = 'CrowdCompass - UK';
            
            system.debug(idForOppNew.Product_Category__c);
            
            if(idForOppNew.Product__c =='Event' && (idForOppNew.Team__c=='BD' || idForOppNew.Team__c=='Product Adoption' || idForOppNew.Team__c=='Ecommerce/CS')){
                idForOppNew.Product_Category__c = 'Event';
            }else{
                // Changes to product category for TPP - below line commented and new line added with the condition for TPP product category
                //if(idForOppNew.Product__c !='CSN' && (idForOppNew.Product_Category__c == null || idForOppNew.Product_Category__c == ''))
                if(idForOppNew.Product__c !='CrowdCompass' && (idForOppNew.Deal_Booked_In__c !='UK Books' || idForOppNew.Deal_Booked_In__c !='US Books' ) && idForOppNew.Product_Category__c != 'TPP') //Changes to product category for TPP 
                 idForOppNew.Product_Category__c = idForOppNew.Product__c;
                system.debug(idForOppNew.Product_Category__c);
            }
            
            if(idForOppNew.Product__c =='Event' && (idForOppNew.Product_Category__c != null || idForOppNew.Product_Category__c ==''))
            setUserId.add(idForOppNew.OwnerId);
            
            //For Onsite Product
            if(idForOppNew.Product__c =='Onsite Solutions' && idForOppNew.Team__c =='Enterprise')
            idForOppNew.Product_Category__c ='Enterprise';
            else if(idForOppNew.Product__c == 'Onsite Solutions' && idForOppNew.Team__c !='Enterprise')
            idForOppNew.Product_Category__c ='Event';
            //For Onsite Product
            
            // Changes for CSN-MSA Records updation and insertion.
                
            // Changes for CSN-MSA Records updation and insertion.
            
            //if(newMapValues.get(idForOppNew.Id).Contract_Implemented__c != oldMapValues.get(idForOppNew.Id).Contract_Implemented__c)
            //mapOppId.put(idForOppNew.id,idForOppNew.id);
            
            //system.debug(mapOppId);
            //system.debug(idForOppNew.Product_Category__c);
            //(Tract)-Whenever an opportunity with with unique contract number is inserted
        }
        //map<Id,Opportunity> mapOpp = new map<Id,Opportunity>();
        //if(mapOppId.keySet().size()>0)
        //mapOpp = new map<ID,Opportunity>([SELECT Id,(SELECT Id,Feature__c FROM R00N00000008aGEXEA2) FROM Opportunity WHERE Id =: mapOppId.keySet()]);
        
        map<Id,User> mapUser = new map<Id,User>();
        if(setUserId.Size()>0)
        mapUser = new map<Id,User>([SELECT Id,UserRole.Name FROM User WHERE Id =: setUserId]);
        
        //(Tract)-On updating and insert get currency rate
        List<DatedConversionRate> lstDateCR =  [SELECT StartDate, IsoCode, ConversionRate FROM DatedConversionRate WHERE (StartDate =: lstDate OR StartDate =: system.Today().adddays(-1))];
        
        map<String,Decimal> mapConv =  new map<String,Decimal>();
        map<String,Decimal> mapConvTodayOrMore =  new map<String,Decimal>();
        for(DatedConversionRate isntOfDCR : lstDateCR){
            system.debug('isntOfDCR.StartDate+++'+isntOfDCR.StartDate);
            system.debug('system.today()+++'+system.today());
            //if(isntOfDCR.StartDate == system.today().adddays(-1)){
                mapConv.put(isntOfDCR.StartDate + isntOfDCR.IsoCode,isntOfDCR.ConversionRate);
            //}
            if(isntOfDCR.StartDate == system.today().adddays(-1)){
                mapConvTodayOrMore.put(isntOfDCR.StartDate + isntOfDCR.IsoCode,isntOfDCR.ConversionRate);
            }
        }
        
        //(Tract)-On updating and insert get currency rate
        
        //(Tract)-Whenever an opportunity with with unique contract number is inserted
        
        List<Opportunity> lstOppThird = new List<Opportunity>();
        
        if(lstOppForError.size() > 0)
        lstOppThird  =  [SELECT o.Id, (SELECT Id FROM OpportunityContactRoles) FROM Opportunity o WHERE Id =: lstOppForError];
        
        List<Opportunity> lstOppSecond = new List<Opportunity>();
        
        if(lstOpp.size()>0)
        lstOppSecond =  [SELECT o.Id,Contact_Associated__c,Contact_Role__c, (SELECT Id FROM OpportunityContactRoles) FROM Opportunity o WHERE Id =: lstOpp];
        
        lstOpp.clear();
        
        List<OpportunityContactRole> lstOppContactRole = new List<OpportunityContactRole>(); 
        system.debug('lstOpp'+lstOpp);
        
        for(Opportunity instOfOppSec : lstOppSecond){
            if(instOfOppSec.OpportunityContactRoles.size()==0){
                OpportunityContactRole instOppContactRole = new OpportunityContactRole();
                instOppContactRole.OpportunityId =  newMapValues.get(instOfOppSec.Id).Id;                 
                instOppContactRole.ContactId = newMapValues.get(instOfOppSec.Id).Contact_Associated__c;       
                instOppContactRole.Role = newMapValues.get(instOfOppSec.Id).Contact_Role__c;                  
                instOppContactRole.IsPrimary =  true;
                lstOppContactRole.add(instOppContactRole);
            }
            //lstOpp.add(instOfOppSec);   
        }           
        
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded
        // Changes for CSN-MSA Records updation and insertion.
        List<Multi_Property_Bundles__c> lstCSNMSA =  [SELECT Id,MSA_Code__c FROM  Multi_Property_Bundles__c WHERE MSA_Code__c != null];
        Map<String,Id> mapCSNMSA = new Map<String,Id>();
        
        for(Multi_Property_Bundles__c instOfCSNMSA : lstCSNMSA){
            mapCSNMSA.put(instOfCSNMSA.MSA_Code__c.trim(),instOfCSNMSA.Id);                    
        }
        // Changes for CSN-MSA Records updation and insertion.
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded
        
        //Validation For sending deal year 1  opp first
        /*
        Set<String> setContrNum =  new Set<String>();
        map<String,String> mapContrDealYr = new map<String,String>();
        for(String instOfStr : mapContrNum.KeySet()){
            List<String> lstStr = new List<String>(); 
            if(mapContrNum.get(instOfStr).size()>1){
                setContrNum.add(instOfStr);
            }
            lstStr = mapContrNum.get(instOfStr);
            lstStr.sort();
            mapContrNum.put(instOfStr,lstStr);
            mapContrDealYr.put(instOfStr,lstStr[lstStr.size()-1]);
        }
        
        List<Opportunity> lstOppVal = new List<Opportunity>();
        system.debug(lstStrContrNo);
        
        if(lstStrContrNo.size()>0)
        lstOppVal = new List<Opportunity>([SELECT Id,Deal_Year__c,Contract_Number_New__c FROM Opportunity WHERE Contract_Number_New__c=:lstStrContrNo AND (Tract_Sales_Order__c = null OR Tract_Sales_Order__c = '') AND AccountId!= null AND Contract_Number_New__c != null AND StageName='Closed Won' AND AccountId =:lstAccIds]);
        
        map<String,Set<String>> mapContrLstYear = new map<String,Set<String>>();
        for(Opportunity  instOfOpp : lstOppVal){
            if(mapContrLstYear.containsKey(instOfOpp.Contract_Number_New__c)){
                Set<String> lstStrYear = mapContrLstYear.get(instOfOpp.Contract_Number_New__c);
                lstStrYear.add(instOfOpp.Deal_Year__c);
                mapContrLstYear.put(instOfOpp.Contract_Number_New__c,lstStrYear);
            }else{
                Set<String> lstStrYear = new Set<String>();
                lstStrYear.add(instOfOpp.Deal_Year__c);
                mapContrLstYear.put(instOfOpp.Contract_Number_New__c,lstStrYear);
            }
        }
        
        for(Opportunity idForOppNew : newMapValues.values()){
            if(setContrNum.contains(idForOppNew.Contract_Number_New__c)){
                idForOppNew.addError('Your list have multiple opps with same contract number and different Deal Years');
            }else{
                for(String instOfStr : mapContrDealYr.KeySet()){
                    if(instOfStr!= '1'){
                        if(mapContrLstYear.containsKey(idForOppNew.Contract_Number_New__c)){
                            if(mapContrLstYear.get(idForOppNew.Contract_Number_New__c).contains(String.valueOf(Integer.valueOf(mapContrDealYr.get(instOfStr))-1)))
                            idForOppNew.addError('Opportunity with Deal Year \'' + String.valueOf(Integer.valueOf(mapContrDealYr.get(instOfStr))-1) + '\'  has not moved yet.' );
                        }
                    }
                }
            }
        }*/
        //Validation For sending deal year 1  opp first
        
        
        //(Tract)-Whenever an opportunity with with unique contract number is inserted
        Integer counter;
        Integer counterSec;
        Integer counterThir;
        for(Opportunity idForOppNew : newMapValues.values()){
            
            //(Tract)-On updating and insert get currency rate
            
            String strDateIso = idForOppNew.CloseDate + idForOppNew.CurrencyIsoCode;
            system.debug(strDateIso);
            system.debug(mapConv);
            if(mapConv.containsKey(strDateIso)){
                idForOppNew.Exchange_Rate__c = mapConv.get(strDateIso);
            }
            
            if(idForOppNew.CloseDate >= system.today()){
                for(String strDateCurr : mapConvTodayOrMore.KeySet()){
                    if(strDateCurr.contains(idForOppNew.CurrencyIsoCode)){
                        if(idForOppNew.Exchange_Rate__c == null)
                        idForOppNew.Exchange_Rate__c = mapConvTodayOrMore.get(strDateCurr);
                    }
                }
            }
            
            //(Tract)-On updating and insert get currency rate
            
            // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded
            // Changes for CSN-MSA Records updation and insertion.
            if(newMapValues.get(idForOppNew.Id).MSA_Code__c != oldMapValues.get(idForOppNew.Id).MSA_Code__c && idForOppNew.MSA_Code__c != null){
                idForOppNew.Bundle_Campaigns__c = mapCSNMSA.get(idForOppNew.MSA_Code__c.trim());
            }
            
            if(idForOppNew.MSA_Code__c == null)
            idForOppNew.Bundle_Campaigns__c = null;
            
            // Changes for CSN-MSA Records updation and insertion.
            // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded
            
            for(Opportunity instOfOppThird :lstOppThird){               
                if(idForOppNew.Id==instOfOppThird.Id){
                    if(instOfOppThird.OpportunityContactRoles.size()==0){
                        if(!Test.isRunningTest()){ 
                            idForOppNew.addError('Please specify a contact with role on fields highlighted below');
                            idForOppNew.Contact_Associated__c.addError('Contact');
                            idForOppNew.Contact_Role__c.addError('Contact Role');
                        }
                    }
                }
            } 
            /*
            if(mapOpp.containsKey(idForOppNew.Id)){
                counter = 0;
                counterSec = 0;
                counterThir = 0;
                Opportunity instOfOpp = mapOpp.get(idForOppNew.Id);
                List<String> lstStr =  new List<String>();
                
                for(Feature_Set__c instOfFeature : instOfOpp.R00N00000008aGEXEA2){
                    if(mapFeatureType.containsKey(instOfFeature.Feature__c.trim()))
                    counter++;
                }
                
                for(Feature_Set__c instOfFeature : instOfOpp.R00N00000008aGEXEA2){
                    if(mapFeatureTypeFTR.containsKey(instOfFeature.Feature__c.trim()))
                    counterSec++;
                }
                
                for(Feature_Set__c instOfFeature : instOfOpp.R00N00000008aGEXEA2){
                    if(mapFeatureTypeNSP.containsKey(instOfFeature.Feature__c.trim())){
                        counterThir++;
                        lstStr.add(instOfFeature.Feature__c.trim());
                    }
                }
                
                if(idForOppNew.License_Type__c!=null){
                    if(mapLicenceType.containsKey(idForOppNew.License_Type__c.trim()))
                    idForOppNew.Product_Category__c = mapLicenceType.get(idForOppNew.License_Type__c.trim());
                }
                
                
                if(counterThir > 0 && idForOppNew.Product_Category__c == null)
                idForOppNew.Product_Category__c = mapFeatureTypeNSP.get(lstStr[0]);
                
                if(counter > 0)
                idForOppNew.Product_Category__c = mapFeatureType.values()[0];
                
                if(counterSec > 0)
                idForOppNew.Product_Category__c = mapFeatureTypeFTR.values()[0];
                
                if(counter > 0 && counterThir > 0){
                    idForOppNew.Product_Category__c = mapFeatureType.values()[0];
                }else if(counterSec > 0 && counterThir > 0){
                    idForOppNew.Product_Category__c = mapFeatureTypeFTR.values()[0];
                }
            }   
            */
            
            if(idForOppNew.Product__c == 'Event'){
                if(mapUser.containsKey(idForOppNew.OwnerId)){
                    User instOfUsr = mapUser.get(idForOppNew.OwnerId);
                    try{
                        if(instOfUsr.UserRole.Name.contains('Event'))
                        idForOppNew.Product_Category__c = 'Event';
                    }catch(exception e){
                        
                    }
                    
                    try{
                    if(instOfUsr.UserRole.Name.contains('(Ent)'))
                    idForOppNew.Product_Category__c = 'Enterprise';
                    }catch(exception e){
                        
                    }
                    
                    try{
                    //Changes to product category for TPP
                    //if(instOfUsr.UserRole.Name.contains('(TPP)'))
                    //idForOppNew.Product_Category__c = 'TPP';
                    if(instOfUsr.UserRole.Name.contains('(TPP)') && (idForOppNew.Contract_Implemented__c != oldMapValues.get(idForOppNew.Id).Contract_Implemented__c || idForOppNew.CFC_Check__c != oldMapValues.get(idForOppNew.Id).CFC_Check__c))
                        idForOppNew.Product_Category__c = 'Event';
                        
                    //Changes to product category for TPP     
                    }catch(exception e){
                        
                    }
                }
            }          
        }
        //(Tract)-Whenever an opportunity with with unique contract number is inserted
        
        if(lstOppContactRole.size()>0)
        insert lstOppContactRole;       
        
    }
        
    public void OnAfterUpdate(Map<Id,Opportunity> oldMapValues,Map<Id,Opportunity> newMapValues){
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded//Rollup Code On Insertion        
        List<String> lstBundleCampId = new List<String>();
        
        //(Tract)-Whenever an opportunity with unique contract number is inserted
        List<String> lstOppCNTract = new List<String>();   
        List<String> lstOppCNTractCSN = new List<String>();    
        List<Id> lstAccId = new List<String>();     
        //(Tract)-Whenever an opportunity with unique contract number is inserted
        
        //(Tract-Compliance)-Concept to move opps for reviewing.
        //map<Id,Opportunity> lstOppCr_ContReviews = new map<Id,Opportunity>();
        //(Tract-Compliance)-Concept to move opps for reviewing.
        
        //On updating Opp currency, Children currency should get updated.
        Set<Id> setOppCurrChange = new Set<Id>();
        //On updating Opp currency, Children currency should get updated.
        
        //Auto movement to tract .
        Set<Id> lstOppsForTract = new Set<Id>();
        //Auto movement to tract .
        
        //Updating contracts record on any opp.
        Set<String> lstOppIdContr = new Set<String>();
        Set<String> setAccId = new Set<String>();
        //Updating contracts record on any opp.
        
        //Updating according to the field value Set_Cancellation_Status__c
        //List<Opportunity> lstUpdatePicklistCancel = new List<Opportunity>();
        List<Id> lstUpdatePicklistInsertIds = new List<Id>();
        //Updating according to the field value Set_Cancellation_Status__c
        
        for(Opportunity idForOppNew : newMapValues.values()){
            //Add by kumud [To avoid recursion and run when reveiwer change at opportuity level] 
            Boolean flagCheckRecursive=CheckRecursive.runOnce();
            if((idForOppNew.Re_Reviewed_by__c !=null && idForOppNew.Re_Reviewed_by__c!= '' && oldMapValues.get(idForOppNew.Id).Re_Reviewed_by__c != idForOppNew.Re_Reviewed_by__c)||(idForOppNew.CFC_Check__c != null && idForOppNew.CFC_Check__c !='' && oldMapValues.get(idForOppNew.Id).CFC_Check__c != idForOppNew.CFC_Check__c) || (idForOppNew.Send_This_To_Tract__c != oldMapValues.get(idForOppNew.Id).Send_This_To_Tract__c )){
                 flagCheckRecursive=true;
            }
            //Add by kumud [To avoid recursion and run when reveiwer change at opportuity level] 
            //Add by kumud [To avoid recursion and run when reveiwer change at opportuity level] 
            if(flagCheckRecursive){
                //Add by kumud [To avoid recursion and run when reveiwer change at opportuity level] 
                if(newMapValues.get(idForOppNew.Id).MSA_Code__c != oldMapValues.get(idForOppNew.Id).MSA_Code__c){
                    if(idForOppNew.MSA_Code__c != null){
                        lstBundleCampId.add(idForOppNew.MSA_Code__c);
                    }else if(idForOppNew.MSA_Code__c == null){
                        lstBundleCampId.add(oldMapValues.get(idForOppNew.Id).MSA_Code__c);  
                    }
                }
                //(Tract-Compliance)-Concept to move opps for reviewing.
                //if(newMapValues.get(idForOppNew.Id).Contract_Implemented__c != oldMapValues.get(idForOppNew.Id).Contract_Implemented__c && newMapValues.get(idForOppNew.Id).Contract_Implemented__c==true){
                    //lstOppCr_ContReviews.put(idForOppNew.Id,idForOppNew); 
                //}
                //(Tract-Compliance)-Concept to move opps for reviewing.
                
                
                
                
                
                //(Tract)-Whenever an opportunity with unique contract number is inserted
                if((idForOppNew.Re_Reviewed_by__c !=null && idForOppNew.Re_Reviewed_by__c!= '' && oldMapValues.get(idForOppNew.Id).Re_Reviewed_by__c != idForOppNew.Re_Reviewed_by__c)||(idForOppNew.CFC_Check__c != null && idForOppNew.CFC_Check__c !='' && oldMapValues.get(idForOppNew.Id).CFC_Check__c != idForOppNew.CFC_Check__c) || (idForOppNew.Send_This_To_Tract__c != oldMapValues.get(idForOppNew.Id).Send_This_To_Tract__c )){
                    //|| (idForOppNew.Error_Corrected_By__c !=  oldMapValues.get(idForOppNew.Id).Error_Corrected_By__c)
                    lstOppCNTract.add(idForOppNew.Contract_Number_New__c);
                    //if(idForOppNew.Product__c == 'CSN'){
                    //  lstOppCNTractCSN.add(idForOppNew.Contract_Number_CSN__c);
                    //  lstOppCNTract.add(idForOppNew.Contract_Number_New__c + 'FTR');
                    //  lstOppCNTract.add(idForOppNew.Contract_Number_New__c + 'CSN');
                    //  lstOppCNTract.add(idForOppNew.Contract_Number_New__c + 'DGB');
                    //  lstOppCNTract.add(idForOppNew.Contract_Number_New__c + 'DPSSLM');
                    //}
                    
                    //Updating contracts record on any opp. 
                    if(idForOppNew.CFC_Check__c != null && idForOppNew.CFC_Check__c !='' && oldMapValues.get(idForOppNew.Id).CFC_Check__c != idForOppNew.CFC_Check__c){
                        lstOppIdContr.add(idForOppNew.Contract_Number_New__c);
                        setAccId.add(idForOppNew.accountId);
                    }
                    //Updating contracts record on any opp. 
                    
                    //Auto movement to tract.
                    if(idForOppNew.Product__c != 'TicketMob' && idForOppNew.Product__c != 'Decision Street' && idForOppNew.Product__c != 'RappidApp' && idForOppNew.Product__c != 'EMI' && idForOppNew.Product__c != 'SignUp4' && idForOppNew.Guaranteed_Check__c != true)
                    lstOppsForTract.add(idForOppNew.id);
                    //Auto movement to tract .
                    
                    if(idForOppNew.AccountId!=null)
                    lstAccId.add(idForOppNew.AccountId);
                }
                //(Tract)-Whenever an opportunity with unique contract number is inserted   
            //Add by kumud [To avoid recursion and run when reveiwer change at opportuity level] 
            }
            //Add by kumud [To avoid recursion and run when reveiwer change at opportuity level] 
            //On updating Opp currency, Children currency should get updated.
            if(newMapValues.get(idForOppNew.Id).CurrencyIsoCode != oldMapValues.get(idForOppNew.Id).CurrencyIsoCode || newMapValues.get(idForOppNew.Id).CloseDate != oldMapValues.get(idForOppNew.Id).CloseDate){
                setOppCurrChange.add(idForOppNew.Id);
            }
            //On updating Opp currency, Children currency should get updated.
            //Updating according to the field value Set_Cancellation_Status__c
            if(idForOppNew.Set_Cancellation_Status__c != oldMapValues.get(idForOppNew.Id).Set_Cancellation_Status__c){
                if(idForOppNew.Set_Cancellation_Status__c == 'Edit & Clone'){
                    //idForOppNew.IsLocked__c   = false;
                    lstUpdatePicklistInsertIds.add(idForOppNew.Id);
                }
            }
            //Updating according to the field value Set_Cancellation_Status__c
        }       
        
        //Updating according to the field value Set_Cancellation_Status__c
        if(lstUpdatePicklistInsertIds.size()>0){
            String soql = getCreatableFieldsSOQL('Opportunity');
            soql = soql + 'lstUpdatePicklistInsertIds';
            OppotunityHelperClsUtil.insertNewOpps(soql,lstUpdatePicklistInsertIds);
        }
        //Updating according to the field value Set_Cancellation_Status__c
        
        //Updating contracts record on any opp. 
        List<Opportunity> lstOppContr = new List<Opportunity>();
        if(lstOppIdContr.size()>0)
        lstOppContr = [SELECT Id,New_Contract_Total__c,Contract_Number_New__c,(SELECT Id,Status FROM Contracts__r) FROM Opportunity WHERE Contract_Number_New__c =: lstOppIdContr AND StageName='Closed Won' AND AccountId=:setAccId];
        
        map<String,Decimal> mapStrTotal = new map<String,Decimal>();
        for(Opportunity instOfOpp : lstOppContr){
            if(mapStrTotal.containsKey(instOfOpp.Contract_Number_New__c)){
                Decimal tempTotal = mapStrTotal.get(instOfOpp.Contract_Number_New__c);
                tempTotal = tempTotal + instOfOpp.New_Contract_Total__c;
                mapStrTotal.put(instOfOpp.Contract_Number_New__c,tempTotal);
            }else{
                mapStrTotal.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Contract_Total__c);
            }
        }
        
        List<Contract> lstContr = new List<Contract>();
        for(Opportunity instOfOpp : lstOppContr){
            for(Contract isntOfContr : instOfOpp.Contracts__r){
                if(mapStrTotal.containsKey(instOfOpp.Contract_Number_New__c)){
                    isntOfContr.Total_Contract_Value__c = mapStrTotal.get(instOfOpp.Contract_Number_New__c);
                    isntOfContr.Status = 'Closed/Executed'; 
                    lstContr.add(isntOfContr);
                }
            }
        }
        
        if(lstContr.size()>0)
        update lstContr;
        //Updating contracts record on any opp. 
        //On updating Opp currency, Children currency should get updated.
        List<Opportunity> lstOfQueried = new List<Opportunity>();
        /*List<Opportunity> lstOfFeatSet = new List<Opportunity>();
        List<Opportunity> lstOfInvoiceDet = new List<Opportunity>();
        List<Opportunity> lstOfInvoiceCred = new List<Opportunity>();
        List<Opportunity> lstOfMSAIso = new List<Opportunity>();
        */
        List<Opportunity> lstOppCr_ContReviewsSec = new List<Opportunity>();
        
        if(setOppCurrChange.size()>0)
        lstOfQueried = [SELECT Id,CurrencyIsoCode,Exchange_Rate__c,(SELECT Id,CurrencyIsoCode,Exchange_Rate__c FROM TM_Fee_Structure__r),(SELECT Id,CurrencyIsoCode,Exchange_Rate__c FROM R00N00000008aGEXEA2),(SELECT Id,CurrencyIsoCode FROM Invoicing_Details__r)
                             ,(SELECT Id,CurrencyIsoCode,Exchange_Rate__c FROM CSN_Credits__r),(SELECT Id,CurrencyIsoCode,Exchange_Rate__c FROM CSN_Campaigns__r) FROM Opportunity WHERE Id =: setOppCurrChange And CurrencyIsoCode != null And Exchange_Rate__c != null];
        
        //(Tract-Compliance)-Concept to move opps for reviewing.
        /*if(lstOppCr_ContReviews.KeySet().size()>0)
        lstOppCr_ContReviewsSec = [SELECT Id,(SELECT Id FROM Contract_Reviews__r) FROM Opportunity WHERE Id =: lstOppCr_ContReviews.KeySet()];
        
        List<Contract_Reviewing__c> lstContRev = new List<Contract_Reviewing__c>();
        
        for(Opportunity instOfOpp : lstOppCr_ContReviewsSec){
            if(instOfOpp.Contract_Reviews__r.Size() == 0){
                Contract_Reviewing__c instOfContRev = new Contract_Reviewing__c();
                instOfContRev.Opportunity__c = instOfOpp.Id;
                instOfContRev.Implementation_Review_ok__c = 'Yes';
                lstContRev.add(instOfContRev);
            }
        }
        
        if(lstContRev.size()>0)
        insert lstContRev;*/
        //(Tract-Compliance)-Concept to move opps for reviewing.
        
        
        /*if(setOppCurrChange.size()>0)
        lstOfFeatSet = [SELECT Id,CurrencyIsoCode,(SELECT Id,CurrencyIsoCode FROM R00N00000008aGEXEA2) FROM Opportunity WHERE Id =: setOppCurrChange];
        
        if(setOppCurrChange.size()>0)
        lstOfInvoiceDet  = [SELECT Id,CurrencyIsoCode,(SELECT Id,CurrencyIsoCode FROM Invoicing_Details__r) FROM Opportunity WHERE Id =: setOppCurrChange];
        
        if(setOppCurrChange.size()>0)
        lstOfInvoiceCred  = [SELECT Id,CurrencyIsoCode,(SELECT Id,CurrencyIsoCode FROM CSN_Credits__r) FROM Opportunity WHERE Id =: setOppCurrChange];
        
        if(setOppCurrChange.size()>0)
        lstOfMSAIso  = [SELECT Id,CurrencyIsoCode,(SELECT Id,CurrencyIsoCode FROM CSN_Campaigns__r) FROM Opportunity WHERE Id =: setOppCurrChange];
        */
        
        List<TM_Fee_Structure__c> lstTMFS =  new List<TM_Fee_Structure__c>();
        List<Feature_Set__c> lstFeatSet =  new List<Feature_Set__c>();
        List<Invoicing_Details__c> lstInvDet =  new List<Invoicing_Details__c>();
        List<CSN_Credit__c> lstCSNCred = new List<CSN_Credit__c>();
        List<Multi_Property_Bundles__c> lstMPB = new List<Multi_Property_Bundles__c>();
        Set<Id> setInvDet = new Set<Id>();
        
        for(Opportunity instOfOpp : lstOfQueried){
            for(TM_Fee_Structure__c instOfTMFS : instOfOpp.TM_Fee_Structure__r){
                instOfTMFS.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                instOfTMFS.Exchange_Rate__c = instOfOpp.Exchange_Rate__c;
                lstTMFS.add(instOfTMFS);
            }
        }
        
        for(Opportunity instOfOpp : lstOfQueried){
            for(Feature_Set__c instOfFeat : instOfOpp.R00N00000008aGEXEA2){
                instOfFeat.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                instOfFeat.Exchange_Rate__c = instOfOpp.Exchange_Rate__c;
                lstFeatSet.add(instOfFeat);
            }
        }
        
        for(Opportunity instOfOpp : lstOfQueried){
            for(Invoicing_Details__c instOfINvDet : instOfOpp.Invoicing_Details__r){
                instOfINvDet.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                //instOfINvDet.Exchange_Rate__c = instOfOpp.Exchange_Rate__c;
                setInvDet.add(instOfINvDet.Id);
                lstInvDet.add(instOfINvDet);
            }
        }
        
        for(Opportunity instOfOpp : lstOfQueried){
            for(CSN_Credit__c instOfCred : instOfOpp.CSN_Credits__r){
                instOfCred.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                instOfCred.Exchange_Rate__c = instOfOpp.Exchange_Rate__c;
                lstCSNCred.add(instOfCred);
            }
        }
        
        for(Opportunity instOfOpp : lstOfQueried){
            for(Multi_Property_Bundles__c instOfMPB : instOfOpp.CSN_Campaigns__r){
                instOfMPB.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                instOfMPB.Exchange_Rate__c = instOfOpp.Exchange_Rate__c;
                lstMPB.add(instOfMPB);
            }
        }
        
        List<Invoicing_Details__c> lstInvDetLI = new List<Invoicing_Details__c>();
        
        
        
        if(lstTMFS.size()>0)
        update lstTMFS;
        
        if(lstFeatSet.size()>0)
        update lstFeatSet;
        
        //if(lstInvDet.size()>0)
        //update lstInvDet;
        
        if(lstCSNCred.size()>0)
        update lstCSNCred;
        
        if(lstMPB.size()>0)
        update lstMPB;
        
        if(setInvDet.size()>0)
        lstInvDetLI = [SELECT Id, Opportunity__r.CurrencyIsoCode,Opportunity__r.Exchange_Rate__c,(SELECT Id,CurrencyIsoCode,Exchange_Rate__c FROM Invoicing_Line_Items__r) FROM Invoicing_Details__c WHERE Id =: setInvDet And Opportunity__r.Exchange_Rate__c != null And Opportunity__r.CurrencyIsoCode != null];
        
        List<Invoicing_Line_Items__c> lstILI = new List<Invoicing_Line_Items__c>();
        
        for(Invoicing_Details__c incvoicingDet : lstInvDetLI){
            for(Invoicing_Line_Items__c instOfInvLI : incvoicingDet.Invoicing_Line_Items__r){
                instOfInvLI.CurrencyIsoCode = incvoicingDet.Opportunity__r.CurrencyIsoCode;
                instOfInvLI.Exchange_Rate__c = incvoicingDet.Opportunity__r.Exchange_Rate__c;
                lstILI.add(instOfInvLI);
            }
        }
        
        if(lstILI.size()>0)
        update lstILI;  
        
        //On updating Opp currency, Children currency should get updated.
        
        List<Multi_Property_Bundles__c> lstMultiPropBund = new List<Multi_Property_Bundles__c>();
        
        if(lstBundleCampId.size()>0)
        lstMultiPropBund =  [SELECT Id,MSA_Total__c,(SELECT ID,New_Contract_Total__c FROM Opportunities_Bund__r) FROM Multi_Property_Bundles__c WHERE MSA_Code__c =: lstBundleCampId];
                
        List<Multi_Property_Bundles__c> lstMultiPropBundSec = new List<Multi_Property_Bundles__c>();
        for(Multi_Property_Bundles__c instOfMutiPropBund : lstMultiPropBund){
            Decimal intContractTot=0;
            for(Opportunity instOfOpp : instOfMutiPropBund.Opportunities_Bund__r){
                intContractTot = intContractTot + instOfOpp.New_Contract_Total__c;
            }
            instOfMutiPropBund.MSA_Total__c = String.valueOf(intContractTot);
            lstMultiPropBundSec.add(instOfMutiPropBund);
        }       
        if(lstMultiPropBundSec.size()>0){
            update lstMultiPropBundSec;
        }
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded//Rollup Code On Insertion
        
        //(Tract)-Whenever an opportunity with unique contract number is inserted
        List<Opportunity> lstOppTract = new List<Opportunity>(); 
        system.debug('lstOppCNTract++'+lstOppCNTract);
        
        if(lstOppCNTract.size()>0)
        lstOppTract = [SELECT Id,Value__c,Opportunity_Start_Date__c,New_Contract_Total__c,CurrencyIsoCode,Opp_End_Date__c,ContractReceived__c,Contract_Number_New__c,License_Type__c,Product_Category__c,Liquidation_Fee__c,MYD_Deal__c,Contract_Type_Tract__c,CloseDate,Parent_Upsell__c,ContractStartDate__c,ContractEndDate__c,OptOutDate__c,Clubbed_Tract_Billing_Account__c,
                            Straight_Total__c,Contract_Number_CSN__c,Milestone_Total__c,Product__c,Year_1_at_Risk__c,Currency__c,New_Type__c,MaintenanceFee__c,New_Amount__c,of_Leads_Purchased__c,Price_per_lead__c,Deal_Year__c,Events__c,Discount__c,Convinience_Fee__c,Forex_rate__c,Tract_Implementation_Date__c,Clubbed_Opportunity__c,Send_This_To_Tract__c,
                            Deal_Booked_In__c,Opp_Type_Classification__c,Name,Accountid,Price_Adjustment__c,Uncounted_Sales_Cancellation_Value__c,Counted_sales_Cancellation_Value__c,Cancellation_Date_Tract__c,(SELECT Id,Total_Fees__c,Feature__c FROM  R00N00000008aGEXEA2) FROM Opportunity WHERE 
                            (Contract_Number_New__c =: lstOppCNTract OR Contract_Number_CSN__c =: lstOppCNTract) AND Contract_Number_New__c != null AND Accountid =:lstAccId AND (StageName =: 'Closed Won' OR StageName =: 'Tract' OR StageName =:'Closed Won - AR Settlement') AND Product__c != 'TicketMob' AND Product__c != 'Decision Street' AND 
                            Product__c != 'RappidApp' AND Product__c != 'EMI' AND Product__c != 'SignUp4' AND Guaranteed_Check__c != true AND Send_This_To_Tract__c = true];
        
        
        map<String,List<Opportunity>> mapStrOpp = new map<String,List<Opportunity>>();
        
        mapStrOpp = contractLstOpp(lstOppTract);
        system.debug('lstOppsForTract++'+lstOppsForTract);
        updateCreateTCV(mapStrOpp,lstOppTract,lstOppsForTract,lstOppCNTract);
    }
    public void OnBeforeDelete(List<Opportunity> oldValues,Map<Id,Opportunity> oldMapValues){
        
    }
    public void OnAfterDelete(List<Opportunity> oldValues,Map<Id,Opportunity> oldMapValues){
        
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded//Rollup Code On Insertion
        List<Id> lstBundleCampId = new List<Id>();      
        for(Opportunity idForOppNew : oldValues){
            lstBundleCampId.add(idForOppNew.Bundle_Campaigns__c);
        }
        List<Multi_Property_Bundles__c> lstMultiPropBund =  new List<Multi_Property_Bundles__c>();
        
        if(lstBundleCampId.size()>0)
        lstMultiPropBund =  [SELECT Id,MSA_Total__c,(SELECT ID,New_Contract_Total__c FROM Opportunities_Bund__r) FROM Multi_Property_Bundles__c WHERE Id =: lstBundleCampId];       
        
        List<Multi_Property_Bundles__c> lstMultiPropBundSec = new List<Multi_Property_Bundles__c>();
        
        for(Multi_Property_Bundles__c instOfMutiPropBund : lstMultiPropBund){
            Decimal intContractTot=0;
            for(Opportunity instOfOpp : instOfMutiPropBund.Opportunities_Bund__r){
                intContractTot = intContractTot + instOfOpp.New_Contract_Total__c;
            }
            instOfMutiPropBund.MSA_Total__c = String.valueOf(intContractTot);
            lstMultiPropBundSec.add(instOfMutiPropBund);
        }       
        
        if(lstMultiPropBundSec.size()>0){
            update lstMultiPropBundSec;
        }
        // Changes for Bundle Campaigns Records updation and insertion.As Object CSN-MSA was discarded//Rollup Code On Insertion
        
    }
    public void OnUndelete(List<Opportunity> newValues){
        
    }
    
    public map<String,List<Opportunity>> contractLstOpp(List<Opportunity> lstOppTract) {
        map<String,List<Opportunity>> mapStrOpp = new map<String,List<Opportunity>>();
        for(Opportunity instOfOpp : lstOppTract){
            /*if(instOfOpp.Product__c == 'CSN'){
                if(mapStrOpp.containskey(instOfOpp.Contract_Number_CSN__c)){
                    List<Opportunity> lstOpp = mapStrOpp.get(instOfOpp.Contract_Number_CSN__c);
                    system.debug('instOfOpp.MYD_Deal__c++'+instOfOpp.MYD_Deal__c);
                    system.debug('instOfOpp.Parent_Upsell__c++'+instOfOpp.Parent_Upsell__c);
                    lstOpp.add(instOfOpp);
                    mapStrOpp.put(instOfOpp.Contract_Number_CSN__c,lstOpp);
                }else{
                    List<Opportunity> lstOpp = new List<Opportunity>();
                    lstOpp.add(instOfOpp);
                    system.debug('instOfOpp.MYD_Deal__c++'+instOfOpp.MYD_Deal__c);
                    system.debug('instOfOpp.Parent_Upsell__c++'+instOfOpp.Parent_Upsell__c);
                    mapStrOpp.put(instOfOpp.Contract_Number_CSN__c,lstOpp);
                }
            }else{*/
                if(mapStrOpp.containskey(instOfOpp.Contract_Number_New__c)){
                    List<Opportunity> lstOpp = mapStrOpp.get(instOfOpp.Contract_Number_New__c);
                    system.debug('instOfOpp.MYD_Deal__c++'+instOfOpp.MYD_Deal__c);
                    system.debug('instOfOpp.Parent_Upsell__c++'+instOfOpp.Parent_Upsell__c);
                    lstOpp.add(instOfOpp);
                    mapStrOpp.put(instOfOpp.Contract_Number_New__c,lstOpp);
                }else{
                    List<Opportunity> lstOpp = new List<Opportunity>();
                    lstOpp.add(instOfOpp);
                    system.debug('instOfOpp.MYD_Deal__c++'+instOfOpp.MYD_Deal__c);
                    system.debug('instOfOpp.Parent_Upsell__c++'+instOfOpp.Parent_Upsell__c);
                    mapStrOpp.put(instOfOpp.Contract_Number_New__c,lstOpp);
                }
            //}
        }
        return mapStrOpp;
    }
    
    public void updateCreateTCV(map<String,List<Opportunity>> mapStrOpp,List<Opportunity> lstOppTract,Set<Id> lstOppsForTract,List<String> lstOppCNTract){
        RecordType instOfRecType = new RecordType();
        if(lstOppCNTract.size()>0)
        instOfRecType = [SELECT ID FROM RecordType WHERE SobjectType='Opportunity' AND DeveloperName = 'Tract' And IsActive = true];
        
        map<String,List<Opportunity>> mapOppWithMaster = new map<String,List<Opportunity>>();
        map<String,List<Opportunity>> mapOppNoMaster = new map<String,List<Opportunity>>(); 
        
        
        Integer counter = 0;
        for(String strContNum : mapStrOpp.keySet()){
            counter = 0;
            system.debug('strContNum++'+strContNum);
            system.debug('mapStrOpp.get(strContNum)++'+mapStrOpp.get(strContNum));
            for(Opportunity instOfOpp : mapStrOpp.get(strContNum)){
                system.debug('mapStrOppinstOfOpp.MYD_Deal__c++'+instOfOpp.MYD_Deal__c);
                system.debug('mapStrOppinstOfOpp.Parent_Upsell__c++'+instOfOpp.Parent_Upsell__c);
                if(instOfOpp.Opp_Type_Classification__c!= null && instOfOpp.Opp_Type_Classification__c != ''){
                    system.debug('Opp_Type_Classification__c+++'+instOfOpp.Opp_Type_Classification__c);
                    system.debug('Opp_Type_Classification__c+++'+instOfOpp.Id);
                    if(instOfOpp.Opp_Type_Classification__c.Contains('Master')){
                        counter++;
                        mapOfMasterOpp.put(instOfOpp.Id,instOfOpp);
                        /*
                        if(instOfOpp.Product__c == 'CSN'){
                            if(mapOfContNumOpp.containskey(instOfOpp.Contract_Number_CSN__c)){
                                List<Opportunity> lstOpp = mapOfContNumOpp.get(instOfOpp.Contract_Number_CSN__c);
                                lstOpp.add(instOfOpp);
                                mapOfContNumOpp.put(instOfOpp.Contract_Number_CSN__c,lstOpp);
                            }else{
                                List<Opportunity> lstOpp = new List<Opportunity>();
                                lstOpp.add(instOfOpp);
                                mapOfContNumOpp.put(instOfOpp.Contract_Number_CSN__c,lstOpp);
                            }
                        }else{*/
                            if(mapOfContNumOpp.containskey(instOfOpp.Contract_Number_New__c)){
                                List<Opportunity> lstOpp = mapOfContNumOpp.get(instOfOpp.Contract_Number_New__c);
                                lstOpp.add(instOfOpp);
                                mapOfContNumOpp.put(instOfOpp.Contract_Number_New__c,lstOpp);
                            }else{
                                List<Opportunity> lstOpp = new List<Opportunity>();
                                lstOpp.add(instOfOpp);
                                mapOfContNumOpp.put(instOfOpp.Contract_Number_New__c,lstOpp);
                            }   
                        //}
                    }
                }
            }
            if(counter > 0){
                List<Opportunity> lstOpp = mapStrOpp.get(strContNum);
                mapOppWithMaster.put(strContNum,lstOpp);
            }else{
                system.debug('mapStrOppinstOfOpp.MYD_Deal__c++'+mapStrOpp.get(strContNum)[0].MYD_Deal__c);
                system.debug('mapStrOppinstOfOpp.Parent_Upsell__c++'+mapStrOpp.get(strContNum)[0].Parent_Upsell__c);
                List<Opportunity> lstOpp = mapStrOpp.get(strContNum);
                system.debug('mapStrOppinstOfOpp.MYD_Deal__c++'+lstOpp[0].MYD_Deal__c);
                system.debug('mapStrOppinstOfOpp.Parent_Upsell__c++'+lstOpp[0].Parent_Upsell__c);
                system.debug('lstOpp++'+lstOpp);
                mapOppNoMaster.put(strContNum,lstOpp);
            }
        }
        system.debug('mapOppNoMaster++'+mapOppNoMaster);
        /*
        map<String,Decimal> mapIdDeciStraight = new map<String,Decimal>();
        map<String,Decimal> mapIdDeciMil = new map<String,Decimal>();
        map<Id,Decimal> mapOppIdFeat = new map<Id,Decimal>();
        map<String,String> mapStraightCheck = new map<String,String>();
        map<String,String> mapMilestoneCheck = new map<String,String>();
        //For CSN
        Decimal counterFTR=0;
        Decimal counterDGB=0;
        Integer counterFTRCheck =0;
        Integer counterDGBCheck =0;
        map<Id,Decimal> mapOppIdTotalFeeFTR = new map<Id,Decimal>();
        map<Id,Decimal> mapOppIdTotalFeeDGB = new map<Id,Decimal>();
        map<Id,Decimal> mapOppIdTotalFeeCSN = new map<Id,Decimal>();
        map<Id,Decimal> mapOppIdTotalFeeDPSSLM = new map<Id,Decimal>();
        
        map<String,Decimal> mapIdDeciStraightFTR = new map<String,Decimal>();
        map<String,Decimal> mapIdDeciStraightDGB = new map<String,Decimal>();
        map<String,Decimal> mapIdDeciStraightCSN = new map<String,Decimal>();
        map<String,Decimal> mapIdDeciStraightDPSSLM = new map<String,Decimal>();
        
        map<String,Decimal> mapDeciTotalYear1CSN = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear2CSN = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear3CSN = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear4CSN = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear5CSN = new map<String,Decimal>();
        
        map<String,Decimal> mapDeciTotalYear1DGB = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear2DGB = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear3DGB = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear4DGB = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear5DGB = new map<String,Decimal>();
        
        map<String,Decimal> mapDeciTotalYear1FTR = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear2FTR = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear3FTR = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear4FTR = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear5FTR = new map<String,Decimal>();
        
        map<String,Decimal> mapDeciTotalYear1DPSSLM = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear2DPSSLM = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear3DPSSLM = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear4DPSSLM = new map<String,Decimal>();
        map<String,Decimal> mapDeciTotalYear5DPSSLM = new map<String,Decimal>();
        
        map<String,Decimal> mapPriceAdjYear5 = new map<String,Decimal>();
        map<String,Decimal> mapPriceAdjYear4 = new map<String,Decimal>();
        map<String,Decimal> mapPriceAdjYear3 = new map<String,Decimal>();
        map<String,Decimal> mapPriceAdjYear2 = new map<String,Decimal>();
        map<String,Decimal> mapPriceAdjYear1 = new map<String,Decimal>();
        
        map<String,Decimal> mapCancellYear5 = new map<String,Decimal>();
        map<String,Decimal> mapCancellYear4 = new map<String,Decimal>();
        map<String,Decimal> mapCancellYear3 = new map<String,Decimal>();
        map<String,Decimal> mapCancellYear2 = new map<String,Decimal>();
        map<String,Decimal> mapCancellYear1 = new map<String,Decimal>();
        */
       
        //For CSN
        getTotals(lstOppTract);
        
        
        /*
        Decimal CancellationAmt = 0; 
        Decimal maintenanceFee = 0;
        Decimal usagePackageFee = 0;
        Decimal Discount = 0;
        Decimal convenienceFee = 0;
        Decimal numOfleadP = 0;
        Decimal numOfEvents = 0;
        Decimal intPrceAdj = 0;
        Decimal intContYear1Total = 0;
        Decimal intContYear2Total = 0;
        Decimal intContYear3Total = 0;
        Decimal intContYear4Total = 0;
        Decimal intContYear5Total = 0;
        Decimal intLiqYear1Total = 0;
        Decimal intLiqYear2Total = 0;
        Decimal intLiqYear3Total = 0;
        Decimal intLiqYear4Total = 0;
        Decimal intLiqYear5Total = 0;
        */
        
        
        system.debug('mapOppIdTotalFeeFTR++'+mapOppIdTotalFeeFTR);
        system.debug('mapOppIdTotalFeeDGB++'+mapOppIdTotalFeeDGB);
        system.debug('mapOppIdTotalFeeCSN++'+mapOppIdTotalFeeCSN);
        system.debug('mapOppIdTotalFeeDPSSLM++'+mapOppIdTotalFeeDPSSLM);
        
        system.debug('mapIdDeciStraightFTR++'+mapIdDeciStraightFTR);
        system.debug('mapIdDeciStraightDGB++'+mapIdDeciStraightDGB);
        system.debug('mapIdDeciStraightCSN++'+mapIdDeciStraightCSN);
        system.debug('mapIdDeciStraightDPSSLM++'+mapIdDeciStraightDPSSLM);
        system.debug('mapDeciTotalYear1CSN++'+mapDeciTotalYear1CSN);
        system.debug('mapDeciTotalYear2CSN++'+mapDeciTotalYear2CSN);
        system.debug('mapDeciTotalYear3CSN++'+mapDeciTotalYear3CSN);
        system.debug('mapDeciTotalYear4CSN++'+mapDeciTotalYear4CSN);
        system.debug('mapDeciTotalYear1DGB++'+mapDeciTotalYear1DGB);
        system.debug('mapDeciTotalYear2DGB++'+mapDeciTotalYear2DGB);
        system.debug('mapDeciTotalYear3DGB++'+mapDeciTotalYear3DGB);
        system.debug('mapDeciTotalYear4DGB++'+mapDeciTotalYear4DGB);
        system.debug('mapDeciTotalYear1FTR++'+mapDeciTotalYear1FTR);
        system.debug('mapDeciTotalYear2FTR++'+mapDeciTotalYear2FTR);
        system.debug('mapDeciTotalYear3FTR++'+mapDeciTotalYear3FTR);
        system.debug('mapDeciTotalYear4FTR++'+mapDeciTotalYear4FTR);
        system.debug('mapDeciTotalYear1DPSSLM++'+mapDeciTotalYear1DPSSLM);
        system.debug('mapDeciTotalYear2DPSSLM++'+mapDeciTotalYear2DPSSLM);
        system.debug('mapDeciTotalYear3DPSSLM++'+mapDeciTotalYear3DPSSLM);
        system.debug('mapDeciTotalYear4DPSSLM++'+mapDeciTotalYear4DPSSLM);
        system.debug('mapOppNoMaster.Keyset()+++'+mapOppNoMaster.Keyset());
        
        if(mapOppNoMaster.Keyset().size()>0){
            insertTCV(instOfRecType,mapOppNoMaster);
        }
        //system.debug('lstOppTractIns+++'+lstOppTractIns[0].Opp_Type_Classification__c+'++lstOppTractIns+++'+lstOppTractIns[0].Opp_Type_Classification__c);
        List<Opportunity> lstOppCSNUpdate =  new List<Opportunity>();
        lstOppCSNUpdate = getCSNList(lstOppTractInsCSN,mapPriceAdjYear5,mapPriceAdjYear4,mapPriceAdjYear3,mapPriceAdjYear2,mapPriceAdjYear1);
        
        if(lstOppCSNUpdate.size()>0)
        lstOppTractIns.addAll(lstOppCSNUpdate);
        
        if(lstOppTractIns.size()>0)
        insert lstOppTractIns;
        
        
        intContYear1Total = 0;
        intContYear2Total = 0;
        intContYear3Total = 0;
        intContYear4Total = 0;
        intContYear5Total = 0;
        intLiqYear1Total = 0;
        intLiqYear2Total = 0;
        intLiqYear3Total = 0;
        intLiqYear4Total = 0;
        intLiqYear5Total = 0;
        
        if(mapOppWithMaster.keySet().size()>0){
            updateTCVS(instOfRecType,mapOppWithMaster);
        }
        //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
        List<Opportunity> lstOppCSNUpdateSec = new List<Opportunity>();
        lstOppCSNUpdateSec = getCSNListSec(lstOppTractUpdCSN,mapPriceAdjYear5,mapPriceAdjYear4,mapPriceAdjYear3,mapPriceAdjYear2,mapPriceAdjYear1,mapCancellYear5,mapCancellYear4,mapCancellYear3,mapCancellYear2,mapCancellYear1);
        
        
        if(lstOppCSNUpdateSec.size()>0)
        lstOppTractUpd.addAll(lstOppCSNUpdateSec);
        //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
        if(lstOppTractUpd.size()>0)
        update lstOppTractUpd;
        
        system.debug('lstOppTractInsert+++'+lstOppTractInsert);
        if(lstOppTractInsert.size()>0)
        insert lstOppTractInsert;
        
        if(lstOppTractdelete.size()>0)
        delete lstOppTractdelete;
        //lstOppTractInsert.clear();
        //(Tract)-Whenever an opportunity with unique contract number is inserted
        
        //Auto movement to tract .
        system.debug('lstOppsForTract++'+lstOppsForTract);
        if(!System.isBatch()){
            if(lstOppsForTract.size()>0){
                TRACT2.TractBatchCreateSalesOrder CreateOrder = new  TRACT2.TractBatchCreateSalesOrder(lstOppsForTract);
                if(!Test.isRunningTest()){ 
                  Database.executeBatch(CreateOrder , 1);
                }    
            } // commented on 12/18/2015 Deactivate Opportunity Movement
        }
        //Auto movement to tract. 
    }
    public void insertTCV(RecordType instOfRecType,map<String,List<Opportunity>> mapOppNoMaster){
        
        Integer counterCheckCSN=0;
        for(String strContNum : mapOppNoMaster.Keyset()){
            maintenanceFee = 0;
            usagePackageFee = 0;
            Discount = 0;
            convenienceFee = 0;
            numOfleadP = 0;
            numOfEvents = 0;
            intPrceAdj = 0;
            oppNameStr = '';
            CancellationAmt = 0;
            cntTotalReview = 0;
            
            intContYear1Total = 0;
            intContYear2Total = 0;
            intContYear3Total = 0;
            intContYear4Total = 0;
            intContYear5Total = 0;
            intLiqYear1Total = 0;
            intLiqYear2Total = 0;
            intLiqYear3Total = 0;
            intLiqYear4Total = 0;
            intLiqYear5Total = 0;
            
            Opportunity instOfOppTractStr = new Opportunity();
            //Opportunity instOfOppTractMil = new Opportunity();
            Opportunity instOfOppTractStrCSN = new Opportunity();
            Opportunity instOfOppTractStrFTR = new Opportunity();
            Opportunity instOfOppTractStrDGB = new Opportunity();
            Opportunity instOfOppTractStrDPSSLM = new Opportunity();
            
            counterCheckCSN=0;
            for(Opportunity instOfOpp : mapOppNoMaster.get(strContNum)){
                system.debug('instOfOpp.Product__c++'+instOfOpp.Product__c);
                if(instOfOpp.Product__c == 'CSN')
                counterCheckCSN++;
            }
            if(counterCheckCSN > 0){
                //if(mapIdDeciStraightFTR.ContainsKey(strContNum))
                //if(mapIdDeciStraightDGB.ContainsKey(strContNum))
                //if(mapIdDeciStraightCSN.ContainsKey(strContNum))
                //if(mapIdDeciStraightDPSSLM.ContainsKey(strContNum))
                
                for(Opportunity instOfOpp : mapOppNoMaster.get(strContNum)){
                    system.debug('instOfOpp.Deal_Year__c++++'+instOfOpp.Deal_Year__c);
                    system.debug('strContNum++++'+strContNum);
                    system.debug('mapIdDeciStraightFTR.ContainsKey(strContNum)++++'+mapIdDeciStraightFTR.ContainsKey(strContNum));
                    if(instOfOpp.Deal_Year__c == '1'){
                        system.debug('instOfOpp.Deal_Year__c++++'+instOfOpp.Deal_Year__c);
                        system.debug('strContNum++++'+strContNum);
                        system.debug('mapIdDeciStraightFTR.ContainsKey(strContNum)++++'+mapIdDeciStraightFTR.ContainsKey(strContNum));
                        if(mapIdDeciStraightFTR.ContainsKey(strContNum)){
                            instOfOppTractStrFTR.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - FTR' +' ' + 'Straightline';
                            instOfOppTractStrFTR.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            instOfOppTractStrFTR.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            instOfOppTractStrFTR.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrFTR.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'FTR';
                            instOfOppTractStrFTR.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrFTR.Contract_Number_New__c = instOfOpp.Contract_Number_New__c; 
                            instOfOppTractStrFTR.ContractReceived__c = instOfOpp.ContractReceived__c;
                            //Adjusting the cancellation amount && Tract implementation Date change
                            instOfOppTractStrFTR.Tract_Implementation_Date__c = system.today();
                            //Adjusting the cancellation amount && Tract implementation Date change
                            instOfOppTractStrFTR.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrFTR.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            if(instOfOpp.Year_1_at_Risk__c != null)
                            instOfOppTractStrFTR.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrFTR.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrFTR.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrFTR.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            instOfOppTractStrFTR.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrFTR.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrFTR.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrFTR.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrFTR.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            instOfOppTractStrFTR.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrFTR.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrFTR.Product_Category_Tract__c = 'CSN - FTR';
                            
                            //instOfOppTractStrFTR.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrFTR.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrFTR.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrFTR.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapIdDeciStraightDGB.ContainsKey(strContNum)){
                            instOfOppTractStrDGB.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DGB' +' ' + 'Straightline';
                            instOfOppTractStrDGB.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            instOfOppTractStrDGB.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            instOfOppTractStrDGB.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDGB.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DGB';
                            instOfOppTractStrDGB.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDGB.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDGB.ContractReceived__c = instOfOpp.ContractReceived__c;
                            //Adjusting the cancellation amount && Tract implementation Date change
                            instOfOppTractStrDGB.Tract_Implementation_Date__c = system.today();
                            //Adjusting the cancellation amount && Tract implementation Date change
                            instOfOppTractStrDGB.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            if(instOfOpp.Year_1_at_Risk__c !=null)
                            instOfOppTractStrDGB.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDGB.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDGB.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDGB.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDGB.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDGB.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDGB.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDGB.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDGB.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDGB.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDGB.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDGB.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDGB.Product_Category_Tract__c = 'CSN - DGB';
                            
                            //instOfOppTractStrDGB.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrDGB.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrDGB.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrDGB.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapIdDeciStraightCSN.ContainsKey(strContNum)){
                            instOfOppTractStrCSN.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN' +' ' + 'Straightline';
                            instOfOppTractStrCSN.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            instOfOppTractStrCSN.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            instOfOppTractStrCSN.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrCSN.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'CSN';
                            instOfOppTractStrCSN.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrCSN.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrCSN.ContractReceived__c = instOfOpp.ContractReceived__c;
                            //Adjusting the cancellation amount && Tract implementation Date change
                            instOfOppTractStrCSN.Tract_Implementation_Date__c = system.today();
                            //Adjusting the cancellation amount && Tract implementation Date change
                            instOfOppTractStrCSN.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            if(instOfOpp.Year_1_at_Risk__c != null)
                            instOfOppTractStrCSN.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c !=null)
                            instOfOppTractStrCSN.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrCSN.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrCSN.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrCSN.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrCSN.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrCSN.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrCSN.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrCSN.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrCSN.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrCSN.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrCSN.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrCSN.Product_Category_Tract__c = 'CSN';
                            
                            //instOfOppTractStrCSN.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrCSN.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrCSN.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrCSN.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapIdDeciStraightDPSSLM.ContainsKey(strContNum)){
                            instOfOppTractStrDPSSLM.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DPS_SLM' +' ' + 'Straightline';
                            instOfOppTractStrDPSSLM.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            instOfOppTractStrDPSSLM.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            instOfOppTractStrDPSSLM.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDPSSLM.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DPSSLM';
                            instOfOppTractStrDPSSLM.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDPSSLM.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDPSSLM.ContractReceived__c = instOfOpp.ContractReceived__c;
                            //Adjusting the cancellation amount && Tract implementation Date change
                            instOfOppTractStrDPSSLM.Tract_Implementation_Date__c = system.today();
                            //Adjusting the cancellation amount && Tract implementation Date change
                            instOfOppTractStrDPSSLM.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            if(instOfOpp.Year_1_at_Risk__c != null)
                            instOfOppTractStrDPSSLM.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDPSSLM.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDPSSLM.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDPSSLM.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;       
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDPSSLM.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDPSSLM.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDPSSLM.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDPSSLM.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDPSSLM.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDPSSLM.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDPSSLM.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDPSSLM.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDPSSLM.Product_Category_Tract__c = 'CSN - DPS_SLM';
                            
                            //instOfOppTractStrDPSSLM.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrDPSSLM.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrDPSSLM.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrDPSSLM.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        system.debug('mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)++++'+mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id));
                        system.debug('instOfOpp.Deal_Year__c++++'+instOfOpp.Deal_Year__c);
                        if(mapOppIdTotalFeeFTR.ContainsKey(instOfOpp.Id)){
                                
                            instOfOppTractStrFTR.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrFTR.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrFTR.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeDGB.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDGB.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDGB.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDGB.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrCSN.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrCSN.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrCSN.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeDPSSLM.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDPSSLM.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDPSSLM.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDPSSLM.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                    }
                    
                    if(instOfOpp.Deal_Year__c == '2'){
                        if(mapOppIdTotalFeeFTR.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrFTR.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrFTR.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrFTR.Year_2_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrFTR.Year_2_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeDGB.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDGB.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrDGB.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDGB.Year_2_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDGB.Year_2_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        system.debug('mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)++++'+mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id));
                        system.debug('instOfOpp.Deal_Year__c++++'+instOfOpp.Deal_Year__c);
                        if(mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrCSN.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrCSN.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrCSN.Year_2_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrCSN.Year_2_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeDPSSLM.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDPSSLM.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;       
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrDPSSLM.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDPSSLM.Year_2_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDPSSLM.Year_2_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                    }
                    
                    if(instOfOpp.Deal_Year__c == '3'){
                        if(mapOppIdTotalFeeFTR.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                                                
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrFTR.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrFTR.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrFTR.Year_3_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrFTR.Year_3_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeDGB.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDGB.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrDGB.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDGB.Year_3_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDGB.Year_3_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrCSN.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrCSN.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrCSN.Year_3_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrCSN.Year_3_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeDPSSLM.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDPSSLM.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;       
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrDPSSLM.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDPSSLM.Year_3_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDPSSLM.Year_3_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                    }
                    
                    if(instOfOpp.Deal_Year__c == '4'){
                        if(mapOppIdTotalFeeFTR.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrFTR.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrFTR.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrFTR.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrFTR.Year_4_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeDGB.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDGB.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrDGB.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDGB.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDGB.Year_4_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrCSN.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrCSN.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrCSN.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrCSN.Year_4_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeDPSSLM.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDPSSLM.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;       
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrDPSSLM.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDPSSLM.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDPSSLM.Year_4_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                    }
                    
                    if(instOfOpp.Deal_Year__c == '5'){
                        if(mapOppIdTotalFeeFTR.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrFTR.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrFTR.Year_5_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrFTR.Year_5_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrFTR.Year_5_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.Year_5_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeDGB.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDGB.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrDGB.Year_5_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDGB.Year_5_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDGB.Year_5_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.Year_5_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrCSN.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrCSN.Year_5_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrCSN.Year_5_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrCSN.Year_5_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.Year_5_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapOppIdTotalFeeDPSSLM.ContainsKey(instOfOpp.Id)){
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDPSSLM.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;       
                                    
                            // Clubbed TRACT billing account for CSN
                            instOfOppTractStrDPSSLM.Year_5_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDPSSLM.Year_5_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDPSSLM.Year_5_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.Year_5_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                    }
                    
                    if(instOfOppTractStrFTR.Opp_Type_Classification__c != null){
                        instOfOppTractStrFTR.Contract_Total_Tract__c = mapIdDeciStraightFTR.get(strContNum);
                        
                        if(mapDeciTotalYear1FTR.containsKey(strContNum))
                        instOfOppTractStrFTR.Year_1_Value__c = mapDeciTotalYear1FTR.get(strContNum);
                        
                        if(mapDeciTotalYear2FTR.containsKey(strContNum))
                        instOfOppTractStrFTR.Year_2_Value__c = mapDeciTotalYear2FTR.get(strContNum);
                        
                        if(mapDeciTotalYear3FTR.containsKey(strContNum))
                        instOfOppTractStrFTR.Year_3_Value__c = mapDeciTotalYear3FTR.get(strContNum);
                        
                        if(mapDeciTotalYear4FTR.containsKey(strContNum))
                        instOfOppTractStrFTR.Year_4_Value__c = mapDeciTotalYear4FTR.get(strContNum);
                        
                        if(mapDeciTotalYear5FTR.containsKey(strContNum))
                        instOfOppTractStrFTR.Year_5_Value__c = mapDeciTotalYear5FTR.get(strContNum);
                        //lstOppTractIns.add(instOfOppTractStrFTR);
                    }
                    
                    if(instOfOppTractStrCSN.Opp_Type_Classification__c != null){
                        instOfOppTractStrCSN.Contract_Total_Tract__c = mapIdDeciStraightCSN.get(strContNum);
                        
                        if(mapDeciTotalYear1CSN.containsKey(strContNum))
                        instOfOppTractStrCSN.Year_1_Value__c = mapDeciTotalYear1CSN.get(strContNum);
                        
                        if(mapDeciTotalYear2CSN.containsKey(strContNum))
                        instOfOppTractStrCSN.Year_2_Value__c = mapDeciTotalYear2CSN.get(strContNum);
                        
                        if(mapDeciTotalYear3CSN.containsKey(strContNum))
                        instOfOppTractStrCSN.Year_3_Value__c = mapDeciTotalYear3CSN.get(strContNum);
                        
                        if(mapDeciTotalYear4CSN.containsKey(strContNum))
                        instOfOppTractStrCSN.Year_4_Value__c = mapDeciTotalYear4CSN.get(strContNum);
                        
                        if(mapDeciTotalYear5CSN.containsKey(strContNum))
                        instOfOppTractStrCSN.Year_5_Value__c = mapDeciTotalYear5CSN.get(strContNum);
                        //lstOppTractIns.add(instOfOppTractStrCSN);
                    }
                    
                    if(instOfOppTractStrDGB.Opp_Type_Classification__c != null){
                        instOfOppTractStrDGB.Contract_Total_Tract__c = mapIdDeciStraightDGB.get(strContNum);
                        
                        if(mapDeciTotalYear1DGB.containsKey(strContNum))
                        instOfOppTractStrDGB.Year_1_Value__c = mapDeciTotalYear1DGB.get(strContNum);
                        
                        if(mapDeciTotalYear2DGB.containsKey(strContNum))
                        instOfOppTractStrDGB.Year_2_Value__c = mapDeciTotalYear2DGB.get(strContNum);
                        
                        if(mapDeciTotalYear3DGB.containsKey(strContNum))
                        instOfOppTractStrDGB.Year_3_Value__c = mapDeciTotalYear3DGB.get(strContNum);
                        
                        if(mapDeciTotalYear4DGB.containsKey(strContNum))
                        instOfOppTractStrDGB.Year_4_Value__c = mapDeciTotalYear4DGB.get(strContNum);
                        
                        if(mapDeciTotalYear5DGB.containsKey(strContNum))
                        instOfOppTractStrDGB.Year_5_Value__c = mapDeciTotalYear5DGB.get(strContNum);
                        //lstOppTractIns.add(instOfOppTractStrDGB);
                    }
                    
                    if(instOfOppTractStrDPSSLM.Opp_Type_Classification__c != null){
                        instOfOppTractStrDPSSLM.Contract_Total_Tract__c = mapIdDeciStraightDPSSLM.get(strContNum);
                        
                        if(mapDeciTotalYear1DPSSLM.containsKey(strContNum))
                        instOfOppTractStrDPSSLM.Year_1_Value__c = mapDeciTotalYear1DPSSLM.get(strContNum);
                        
                        if(mapDeciTotalYear2DPSSLM.containsKey(strContNum))
                        instOfOppTractStrDPSSLM.Year_2_Value__c = mapDeciTotalYear2DPSSLM.get(strContNum);
                        
                        if(mapDeciTotalYear3DPSSLM.containsKey(strContNum))
                        instOfOppTractStrDPSSLM.Year_3_Value__c = mapDeciTotalYear3DPSSLM.get(strContNum);
                        
                        if(mapDeciTotalYear4DPSSLM.containsKey(strContNum))
                        instOfOppTractStrDPSSLM.Year_4_Value__c = mapDeciTotalYear4DPSSLM.get(strContNum);
                        
                        if(mapDeciTotalYear5DPSSLM.containsKey(strContNum))
                        instOfOppTractStrDPSSLM.Year_5_Value__c = mapDeciTotalYear5DPSSLM.get(strContNum);
                        //lstOppTractIns.add(instOfOppTractStrDPSSLM);
                    }
                }
                if(instOfOppTractStrFTR.Opp_Type_Classification__c !=null)
                lstOppTractInsCSN.add(instOfOppTractStrFTR);
                if(instOfOppTractStrCSN.Opp_Type_Classification__c !=null)
                lstOppTractInsCSN.add(instOfOppTractStrCSN);
                if(instOfOppTractStrDGB.Opp_Type_Classification__c !=null)
                lstOppTractInsCSN.add(instOfOppTractStrDGB);
                if(instOfOppTractStrDPSSLM.Opp_Type_Classification__c !=null)
                lstOppTractInsCSN.add(instOfOppTractStrDPSSLM);
                
                system.debug('lstOppTractInsCSN++'+lstOppTractInsCSN);
                
            }else{
                for(Opportunity instOfOpp : mapOppNoMaster.get(strContNum)){
                    system.debug('instOfOpp.Contract_Number_New__c++'+instOfOpp.Contract_Number_New__c);
                    system.debug('instOfOppTractStr.MYD_Deal__c++'+instOfOppTractStr.MYD_Deal__c);
                    system.debug('instOfOppTractStr.Parent_Upsell__c++'+instOfOppTractStr.Parent_Upsell__c);
                    if(instOfOpp.Deal_Year__c == '1'){
                        
                        instOfOppTractStr.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                        instOfOppTractStr.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                        instOfOppTractStr.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                        instOfOppTractStr.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                        instOfOppTractStr.Product__c = instOfOpp.Product__c;
                        instOfOppTractStr.ContractReceived__c = instOfOpp.ContractReceived__c;
                        instOfOppTractStr.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                        //Adjusting the cancellation amount && Tract implementation Date change
                        instOfOppTractStr.Tract_Implementation_Date__c = system.today();
                        //Adjusting the cancellation amount && Tract implementation Date change
                        if(instOfOpp.OptOutDate__c !=null)
                        instOfOppTractStr.OptOutDate__c = instOfOpp.OptOutDate__c;
                        
                        if(instOfOpp.Year_1_at_Risk__c !=null)
                        instOfOppTractStr.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                        
                        if(instOfOpp.Currency__c !=null)
                        instOfOppTractStr.Currency__c = instOfOpp.Currency__c;
                        
                        if(instOfOpp.Forex_rate__c !=null)
                        instOfOppTractStr.Forex_rate__c = instOfOpp.Forex_rate__c;
                        
                        if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')
                        instOfOppTractStr.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;
                                
                        instOfOppTractStr.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                        instOfOppTractStr.AccountId = instOfOpp.AccountId;
                        instOfOppTractStr.Opp_Type_Classification__c = 'Master Straightline';
                        instOfOppTractStr.StageName = 'Tract';
                        
                        if(instOfOpp.Price_per_lead__c != null)
                        instOfOppTractStr.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                        instOfOppTractStr.CloseDate = instOfOpp.CloseDate;
                        instOfOppTractStr.RecordTypeId = instOfRecType.Id;
                        instOfOppTractStr.Product_Category_Tract__c = instOfOpp.Product_Category__c;
                        oppNameStr = mapMonth.get(instOfOpp.CloseDate.month())+' ' + String.valueOf(instOfOpp.CloseDate.year());
                        
                        /*
                        instOfOppTractMil.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                        instOfOppTractMil.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                        instOfOppTractMil.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                        instOfOppTractMil.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                        instOfOppTractMil.Product__c = instOfOpp.Product__c;
                        instOfOppTractMil.OptOutDate__c = instOfOpp.OptOutDate__c;
                        instOfOppTractMil.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                        instOfOppTractMil.Currency__c = instOfOpp.Currency__c;
                        instOfOppTractMil.Forex_rate__c = instOfOpp.Forex_rate__c;
                        instOfOppTractMil.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                        instOfOppTractMil.AccountId = instOfOpp.AccountId;
                        instOfOppTractMil.Opp_Type_Classification__c = 'Master Milestone';
                        instOfOppTractMil.StageName = 'Tract';
                        instOfOppTractMil.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                        instOfOppTractMil.RecordTypeId = instOfRecType.Id;
                        instOfOppTractMil.CloseDate = instOfOpp.CloseDate;
                        instOfOppTractMil.Product_Category_Tract__c = instOfOpp.Product_Category__c;
                        */
                    }
                    if(instOfOpp.Deal_Year__c != null){
                        if(instOfOpp.Deal_Year__c == '1'){
                        
                            instOfOppTractStr.Year_1_Contract_Type__c = instOfOpp.New_Type__c;
                            
                            //if(instOfOpp.Value__c != null){
                            Double intTotal = 0;
                            if(instOfOpp.MaintenanceFee__c != null){
                                intTotal = instOfOpp.MaintenanceFee__c;
                            }
                            if(instOfOpp.New_Amount__c != null){
                                intTotal = intTotal + instOfOpp.New_Amount__c;
                            }
                            if(instOfOpp.Convinience_Fee__c != null){
                                intTotal = intTotal + instOfOpp.Convinience_Fee__c;
                            }
                            if(mapOppIdFeat.containsKey(instOfOpp.Id)){
                                intTotal = intTotal + mapOppIdFeat.get(instOfOpp.Id);
                            }
                            if(instOfOpp.Discount__c != null){
                                intTotal = intTotal - instOfOpp.Discount__c;
                            }
                            if(instOfOpp.Price_Adjustment__c != null){
                                intTotal = intTotal + instOfOpp.Price_Adjustment__c;
                            }
                            
                            intContYear1Total = intContYear1Total + intTotal;
                            
                            //Adjusting the cancellation amount
                            if(instOfOpp.Counted_sales_Cancellation_Value__c != null)
                            intContYear1Total = intContYear1Total - instOfOpp.Counted_sales_Cancellation_Value__c;
                            //Adjusting the cancellation amount
                            
                            instOfOppTractStr.Year_1_Value__c = intContYear1Total;
                            //}
                            instOfOppTractStr.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStr.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStr.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            if(instOfOpp.Liquidation_Fee__c != null){
                                intLiqYear1Total = intLiqYear1Total + instOfOpp.Liquidation_Fee__c;
                                instOfOppTractStr.Year_1_Liquidation_fee__c = intLiqYear1Total;
                            }
                            if(instOfOpp.OptOutDate__c != null){
                                instOfOppTractStr.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                            }
                            
                            /*
                            instOfOppTractMil.Year_1_Contract_Type__c = instOfOpp.New_Type__c;
                            if(instOfOpp.Value__c != null){
                                instOfOppTractMil.Year_1_Value__c = instOfOpp.Value__c;
                            }
                            instOfOppTractMil.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractMil.Year_1_Start_Date__c = instOfOpp.ContractStartDate__c;
                            instOfOppTractMil.Year_1_End_Date__c = instOfOpp.ContractEndDate__c;
                            if(instOfOpp.OptOutDate__c != null){
                                instOfOppTractMil.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                            }
                            if(instOfOpp.Liquidation_Fee__c != null){
                                instOfOppTractMil.Year_1_Liquidation_fee__c = instOfOpp.Liquidation_Fee__c;
                            }*/
                        }else if(instOfOpp.Deal_Year__c == '2'){
                            
                            instOfOppTractStr.Year_2_Contract_Type__c = instOfOpp.New_Type__c;
                            //if(instOfOpp.Value__c != null){
                            
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')
                            instOfOppTractStr.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;
                            
                            Double intTotal = 0;
                            if(instOfOpp.MaintenanceFee__c != null){
                                intTotal = instOfOpp.MaintenanceFee__c;
                            }
                            if(instOfOpp.New_Amount__c != null){
                                intTotal = intTotal + instOfOpp.New_Amount__c;
                            }
                            if(instOfOpp.Convinience_Fee__c != null){
                                intTotal = intTotal + instOfOpp.Convinience_Fee__c;
                            }
                            if(mapOppIdFeat.containsKey(instOfOpp.Id)){
                                intTotal = intTotal + mapOppIdFeat.get(instOfOpp.Id);
                            }
                            if(instOfOpp.Discount__c != null){
                                intTotal = intTotal - instOfOpp.Discount__c;
                            }
                            if(instOfOpp.Price_Adjustment__c != null){
                                intTotal = intTotal + instOfOpp.Price_Adjustment__c;
                            }
                            
                            intContYear2Total = intContYear2Total + intTotal;
                            
                            //Adjusting the cancellation amount
                            if(instOfOpp.Counted_sales_Cancellation_Value__c != null)
                            intContYear2Total = intContYear2Total - instOfOpp.Counted_sales_Cancellation_Value__c;
                            //Adjusting the cancellation amount
                            
                            instOfOppTractStr.Year_2_Value__c = intContYear2Total;
                            //}
                            instOfOppTractStr.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStr.Year_2_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStr.Year_2_End_Date__c = instOfOpp.Opp_End_Date__c;
                            if(instOfOpp.Liquidation_Fee__c != null){
                                intLiqYear2Total = intLiqYear2Total + instOfOpp.Liquidation_Fee__c;
                                instOfOppTractStr.Year_2_Liquidation_fee__c = intLiqYear2Total;
                            }
                            if(instOfOpp.OptOutDate__c != null){
                                instOfOppTractStr.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                            }
                            
                            /*
                            instOfOppTractMil.Year_2_Contract_Type__c = instOfOpp.New_Type__c;
                            if(instOfOpp.Value__c != null){
                                instOfOppTractMil.Year_2_Value__c = instOfOpp.Value__c; 
                            }
                            instOfOppTractMil.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractMil.Year_2_Start_Date__c = instOfOpp.ContractStartDate__c;
                            instOfOppTractMil.Year_2_End_Date__c = instOfOpp.ContractEndDate__c;
                            if(instOfOpp.OptOutDate__c != null){
                                instOfOppTractMil.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c; 
                            }
                            if(instOfOpp.Liquidation_Fee__c != null){
                                instOfOppTractMil.Year_2_Liquidation_fee__c = instOfOpp.Liquidation_Fee__c;
                            }
                            */
                        
                        }else if(instOfOpp.Deal_Year__c == '3'){
                            
                           
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')
                            instOfOppTractStr.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;
                            
                            instOfOppTractStr.Year_3_Contract_Type__c = instOfOpp.New_Type__c;
                            //if(instOfOpp.Value__c != null){
                            Double intTotal = 0;
                            if(instOfOpp.MaintenanceFee__c != null){
                                intTotal = instOfOpp.MaintenanceFee__c;
                            }
                            if(instOfOpp.New_Amount__c != null){
                                intTotal = intTotal + instOfOpp.New_Amount__c;
                            }
                            if(instOfOpp.Convinience_Fee__c != null){
                                intTotal = intTotal + instOfOpp.Convinience_Fee__c;
                            }
                            if(mapOppIdFeat.containsKey(instOfOpp.Id)){
                                intTotal = intTotal + mapOppIdFeat.get(instOfOpp.Id);
                            }
                            if(instOfOpp.Discount__c != null){
                                intTotal = intTotal - instOfOpp.Discount__c;
                            }
                            if(instOfOpp.Price_Adjustment__c != null){
                                intTotal = intTotal + instOfOpp.Price_Adjustment__c;
                            }
                            
                            //Adjusting the cancellation amount
                            if(instOfOpp.Counted_sales_Cancellation_Value__c != null)
                            intContYear3Total = intContYear3Total - instOfOpp.Counted_sales_Cancellation_Value__c;
                            //Adjusting the cancellation amount
                            
                            intContYear3Total = intContYear3Total + intTotal;
                            instOfOppTractStr.Year_3_Value__c = intContYear3Total; 
                            //}
                            instOfOppTractStr.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStr.Year_3_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStr.Year_3_End_Date__c = instOfOpp.Opp_End_Date__c;
                            if(instOfOpp.Liquidation_Fee__c != null){
                                intLiqYear3Total = intLiqYear3Total + instOfOpp.Liquidation_Fee__c;
                                instOfOppTractStr.Year_3_Liquidation_fee__c = intLiqYear3Total;
                            }
                            if(instOfOpp.OptOutDate__c != null){
                                instOfOppTractStr.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                            }
                            
                            /*
                            instOfOppTractMil.Year_3_Contract_Type__c = instOfOpp.New_Type__c;
                            if(instOfOpp.Value__c != null){
                                instOfOppTractMil.Year_3_Value__c = instOfOpp.Value__c;
                            }
                            instOfOppTractMil.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractMil.Year_3_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractMil.Year_3_End_Date__c = instOfOpp.ContractEndDate__c;
                            if(instOfOpp.OptOutDate__c != null){
                                instOfOppTractMil.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                            }
                            if(instOfOpp.Liquidation_Fee__c != null){
                                instOfOppTractMil.Year_3_Liquidation_fee__c = instOfOpp.Liquidation_Fee__c;
                            }
                            */
                        }else if(instOfOpp.Deal_Year__c == '4'){
                            instOfOppTractStr.Year_4_Contract_Type__c = instOfOpp.New_Type__c;
                            //if(instOfOpp.Value__c != null){
                            
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')
                            instOfOppTractStr.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;
                            
                            Double intTotal = 0;
                            if(instOfOpp.MaintenanceFee__c != null){
                                intTotal = instOfOpp.MaintenanceFee__c;
                            }
                            if(instOfOpp.New_Amount__c != null){
                                intTotal = intTotal + instOfOpp.New_Amount__c;
                            }
                            if(instOfOpp.Convinience_Fee__c != null){
                                intTotal = intTotal + instOfOpp.Convinience_Fee__c;
                            }
                            if(mapOppIdFeat.containsKey(instOfOpp.Id)){
                                intTotal = intTotal + mapOppIdFeat.get(instOfOpp.Id);
                            }
                            if(instOfOpp.Discount__c != null){
                                intTotal = intTotal - instOfOpp.Discount__c;
                            }
                            if(instOfOpp.Price_Adjustment__c != null){
                                intTotal = intTotal + instOfOpp.Price_Adjustment__c;
                            }
                            
                            intContYear4Total = intContYear4Total + intTotal;
                            
                            //Adjusting the cancellation amount
                            if(instOfOpp.Counted_sales_Cancellation_Value__c != null)
                            intContYear4Total = intContYear4Total - instOfOpp.Counted_sales_Cancellation_Value__c;
                            //Adjusting the cancellation amount
                            
                            instOfOppTractStr.Year_4_Value__c = intContYear4Total;
                            //}
                            instOfOppTractStr.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStr.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStr.Year_4_End_Date__c = instOfOpp.Opp_End_Date__c;
                            if(instOfOpp.Liquidation_Fee__c != null){
                                intLiqYear4Total = intLiqYear4Total + instOfOpp.Liquidation_Fee__c;
                                instOfOppTractStr.Year_4_Liquidation_fee__c = intLiqYear4Total;
                            }
                            if(instOfOpp.OptOutDate__c != null){
                                instOfOppTractStr.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c; 
                            }
                            
                            /*
                            instOfOppTractMil.Year_4_Contract_Type__c = instOfOpp.New_Type__c;
                            if(instOfOpp.Value__c != null){
                                instOfOppTractMil.Year_4_Value__c = instOfOpp.Value__c; 
                            }
                            instOfOppTractMil.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractMil.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractMil.Year_4_End_Date__c = instOfOpp.ContractEndDate__c;
                            if(instOfOpp.OptOutDate__c != null){
                                instOfOppTractMil.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c; 
                            }
                            if(instOfOpp.Liquidation_Fee__c != null){
                                instOfOppTractMil.Year_4_Liquidation_fee__c = instOfOpp.Liquidation_Fee__c;
                            }
                            */
                        }else if(instOfOpp.Deal_Year__c == '5'){
                            
                            instOfOppTractStr.Year_5_Contract_Type__c = instOfOpp.New_Type__c;
                            //if(instOfOpp.Value__c != null){
                            
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')
                            instOfOppTractStr.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;
                            
                            Double intTotal = 0;
                            if(instOfOpp.MaintenanceFee__c != null){
                                intTotal = instOfOpp.MaintenanceFee__c;
                            }
                            if(instOfOpp.New_Amount__c != null){
                                intTotal = intTotal + instOfOpp.New_Amount__c;
                            }
                            if(instOfOpp.Convinience_Fee__c != null){
                                intTotal = intTotal + instOfOpp.Convinience_Fee__c;
                            }
                            if(mapOppIdFeat.containsKey(instOfOpp.Id)){
                                intTotal = intTotal + mapOppIdFeat.get(instOfOpp.Id);
                            }
                            if(instOfOpp.Discount__c != null){
                                intTotal = intTotal - instOfOpp.Discount__c;
                            }
                            if(instOfOpp.Price_Adjustment__c != null){
                                intTotal = intTotal + instOfOpp.Price_Adjustment__c;
                            }
                            
                            intContYear5Total = intContYear5Total + intTotal;
                            
                            //Adjusting the cancellation amount
                            if(instOfOpp.Counted_sales_Cancellation_Value__c != null)
                            intContYear5Total = intContYear5Total - instOfOpp.Counted_sales_Cancellation_Value__c;
                            //Adjusting the cancellation amount
                            
                            instOfOppTractStr.Year_5_Value__c = intContYear5Total;
                            //}
                            instOfOppTractStr.Year_5_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStr.Year_5_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStr.Year_5_End_Date__c = instOfOpp.Opp_End_Date__c;
                            if(instOfOpp.Liquidation_Fee__c != null){
                                intLiqYear5Total = intLiqYear5Total + instOfOpp.Liquidation_Fee__c;
                                instOfOppTractStr.Year_5_Liquidation_fee__c = intLiqYear5Total;
                            }
                            if(instOfOpp.OptOutDate__c != null){
                                instOfOppTractStr.Year_5_Opt_out_Date__c = instOfOpp.OptOutDate__c; 
                            }
                            
                            /*
                            instOfOppTractMil.Year_4_Contract_Type__c = instOfOpp.New_Type__c;
                            if(instOfOpp.Value__c != null){
                                instOfOppTractMil.Year_4_Value__c = instOfOpp.Value__c; 
                            }
                            instOfOppTractMil.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractMil.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractMil.Year_4_End_Date__c = instOfOpp.ContractEndDate__c;
                            if(instOfOpp.OptOutDate__c != null){
                                instOfOppTractMil.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c; 
                            }
                            if(instOfOpp.Liquidation_Fee__c != null){
                                instOfOppTractMil.Year_4_Liquidation_fee__c = instOfOpp.Liquidation_Fee__c;
                            }
                            */
                        }
                    }
                    
                    if(instOfOpp.New_Contract_Total__c != null){
                        cntTotalReview = cntTotalReview + instOfOpp.New_Contract_Total__c;
                    }
                    
                    if(instOfOpp.MaintenanceFee__c != null){
                        maintenanceFee = maintenanceFee + instOfOpp.MaintenanceFee__c;
                    }
                    if(instOfOpp.New_Amount__c != null){
                        usagePackageFee = usagePackageFee + instOfOpp.New_Amount__c;
                    }
                    if(instOfOpp.Discount__c != null){
                        Discount = Discount + instOfOpp.Discount__c;
                    }
                    if(instOfOpp.Convinience_Fee__c != null){
                        convenienceFee = convenienceFee + instOfOpp.Convinience_Fee__c;
                    } 
                    if(instOfOpp.of_Leads_Purchased__c != null){
                        numOfleadP =  numOfleadP + instOfOpp.of_Leads_Purchased__c;
                    }
                    if(instOfOpp.Events__c != null){
                        numOfEvents = numOfEvents + instOfOpp.Events__c;
                    }
                    if(instOfOpp.Price_Adjustment__c != null){
                        intPrceAdj = intPrceAdj + instOfOpp.Price_Adjustment__c;
                    }
                    if(instOfOpp.Counted_sales_Cancellation_Value__c != null){
                        CancellationAmt =  CancellationAmt  + instOfOpp.Counted_sales_Cancellation_Value__c;
                    }
                }
            }
            
            if(counterCheckCSN == 0){
                Decimal temp;
                try{ 
                    temp = 0 +mapIdDeciStraight.get(strContNum);
                } catch (exception e){
                    temp = 0;
                }
                Decimal tempSec;
                try{ 
                    tempSec = 0 +mapIdDeciMil.get(strContNum);
                } catch (exception e){
                    tempSec = 0;
                }
                Decimal contTotal =  maintenanceFee + usagePackageFee + temp;
                instOfOppTractStr.Name = instOfOppTractStr.Product__c +' '  + oppNameStr +' '  + instOfOppTractStr.Contract_Type_Tract__c +' '  + 'Straightline';
                instOfOppTractStr.MaintenanceFee__c = maintenanceFee;
                instOfOppTractStr.New_Amount__c = usagePackageFee;
                instOfOppTractStr.Discount__c = Discount;
                instOfOppTractStr.Convinience_Fee__c = convenienceFee;
                instOfOppTractStr.of_Leads_Purchased__c = numOfleadP;
                instOfOppTractStr.Events__c = numOfEvents;
                instOfOppTractStr.Straight_Total__c = maintenanceFee + usagePackageFee + temp;
                system.debug('maintenanceFee+++'+maintenanceFee);
                system.debug('usagePackageFee+++'+usagePackageFee);
                //system.debug('mapIdDeciStraight.get(strContNum)+++'+mapIdDeciStraight.get(strContNum));
                instOfOppTractStr.Straight_Total__c = maintenanceFee + usagePackageFee + temp + convenienceFee;
                instOfOppTractStr.Contract_Total_Tract__c = (maintenanceFee + usagePackageFee + temp + convenienceFee + intPrceAdj) - (Discount + CancellationAmt);
                instOfOppTractStr.Milestone_Total__c = tempSec;
                instOfOppTractStr.Contract_Total_Tract_Review__c = cntTotalReview;
                
                contTotal =  temp;
                /*
                instOfOppTractMil.Name = instOfOppTractMil.Product__c +' ' + oppNameStr +' '  + instOfOppTractStr.Contract_Type_Tract__c +' ' + 'Milestone';
                instOfOppTractMil.MaintenanceFee__c = maintenanceFee;
                instOfOppTractMil.New_Amount__c = usagePackageFee;
                instOfOppTractMil.Discount__c = Discount;
                instOfOppTractMil.Convinience_Fee__c = convenienceFee;
                instOfOppTractMil.of_Leads_Purchased__c = numOfleadP;
                instOfOppTractMil.Events__c = numOfEvents;
                
                instOfOppTractMil.Straight_Total__c = (maintenanceFee + usagePackageFee + temp) - (Discount + intPrceAdj);
                instOfOppTractMil.Contract_Total_Tract__c = temp;
                instOfOppTractMil.Milestone_Total__c = tempSec;
                */
                if(mapStraightCheck.containsKey(strContNum) || (!mapStraightCheck.containsKey(strContNum) && !mapMilestoneCheck.containsKey(strContNum)))
                lstOppTractIns.add(instOfOppTractStr);
                //lstOppTractIns.add(instOfOppTractMil);
            }
        }
        
    }
    public void updateTCVS(RecordType instOfRecType,map<String,List<Opportunity>> mapOppWithMaster){
        
        //For CSN
        Integer counterCheckCSN = 0;
        Date dateCancelYear1 = null;
        Date dateCancelYear2 = null;
        Date dateCancelYear3 = null;
        Date dateCancelYear4 = null;
        Date dateCancelYear5 = null; 
        //For CSN
        for(String strContNum : mapOppWithMaster.KeySet()){
            system.debug('strContNum++'+strContNum);
            system.debug('mapOfContNumOpp.get(strContNum)++'+mapOfContNumOpp.get(strContNum));
            List<Opportunity> lstOpp = mapOfContNumOpp.get(strContNum);
            map<String,String> mapDealYearStr = new map<String,String>();
            maintenanceFee = 0;
            usagePackageFee = 0;
            Discount = 0;
            convenienceFee = 0;
            numOfleadP = 0;
            numOfEvents = 0;
            oppNameStr = '';
            intPrceAdj = 0;
            CancellationAmt = 0;
            cntTotalReview = 0;
            
            intContYear1Total = 0;
            intContYear2Total = 0;
            intContYear3Total = 0;
            intContYear4Total = 0;
            intContYear5Total = 0;
            intLiqYear1Total = 0;
            intLiqYear2Total = 0;
            intLiqYear3Total = 0;
            intLiqYear4Total = 0;
            intLiqYear5Total = 0;
            //For CSN
            Opportunity instOfOppTractStrCSN = new Opportunity();
            Opportunity instOfOppTractStrFTR = new Opportunity();
            Opportunity instOfOppTractStrDGB = new Opportunity();
            Opportunity instOfOppTractStrDPSSLM = new Opportunity();
            
            Integer csnCheck = 0;
            Integer ftrCheck = 0;
            Integer dgbCheck = 0;
            Integer dpsslmCheck = 0;
            
            Integer csnDelete = 0;
            Integer ftrDelete = 0;
            Integer dgbDelete = 0;
            Integer dpsslmDelete = 0;
            
            Boolean csnDateCheck = false;
            Boolean ftrDateCheck = false;
            Boolean dgbDateCheck = false;
            Boolean dpssDateCheck = false;
            
            counterCheckCSN=0;
            for(Opportunity instOfOpp : mapOppWithMaster.get(strContNum)){
                system.debug('instOfOpp.Product__c++'+instOfOpp.Product__c);
                system.debug('instOfOpp.Name+++'+instOfOpp.Name);
                system.debug('instOfOpp.Contract_Number_CSN__c+++'+instOfOpp.Contract_Number_CSN__c);
                system.debug('instOfOpp.Contract_Number_New__c+++'+instOfOpp.Contract_Number_New__c);
                system.debug('instOfOpp.Contract_Number_CSN__c+++'+instOfOpp.Contract_Number_CSN__c);
                if(instOfOpp.Contract_Number_CSN__c != null){
                    if(instOfOpp.Contract_Number_CSN__c.contains('CSN')){
                        instOfOppTractStrCSN =  instOfOpp;  
                        csnCheck++;
                    }
                
                    if(instOfOpp.Contract_Number_CSN__c.contains('FTR')){
                        instOfOppTractStrFTR =  instOfOpp;  
                        ftrCheck++;
                    }
                    
                    if(instOfOpp.Contract_Number_CSN__c.contains('DGB')){
                        instOfOppTractStrDGB =  instOfOpp;
                        dgbCheck++;
                    }
                    
                    if(instOfOpp.Contract_Number_CSN__c.contains('DPSSLM')){
                        instOfOppTractStrDPSSLM =  instOfOpp;
                        dpsslmCheck++;
                    }
                }
                if(instOfOpp.Product__c == 'CSN')
                counterCheckCSN++;
            }
            if(counterCheckCSN > 0){
                
                for(Opportunity instOfOpp : mapOppWithMaster.get(strContNum)){
                    
                    system.debug('instOfOpp.Deal_Year__c++++'+instOfOpp.Deal_Year__c);
                    system.debug('strContNum++++'+strContNum);
                    system.debug('mapIdDeciStraightFTR.ContainsKey(strContNum)++++'+mapIdDeciStraightFTR.ContainsKey(strContNum));
                    if(instOfOpp.Deal_Year__c == '1'){
                        system.debug('instOfOpp.Deal_Year__c++++'+instOfOpp.Deal_Year__c);
                        system.debug('strContNum++++'+strContNum);
                        system.debug('mapIdDeciStraightFTR.ContainsKey(strContNum)++++'+mapIdDeciStraightFTR.ContainsKey(strContNum));
                        if(mapIdDeciStraightFTR.ContainsKey(strContNum)){
                            ftrDelete++;
                            instOfOppTractStrFTR.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - FTR' +' ' + 'Straightline';
                            instOfOppTractStrFTR.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            instOfOppTractStrFTR.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            instOfOppTractStrFTR.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrFTR.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'FTR';
                            instOfOppTractStrFTR.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrFTR.Contract_Number_New__c = instOfOpp.Contract_Number_New__c; 
                            instOfOppTractStrFTR.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrFTR.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            //instOfOppTractStrFTR.Tract_Implementation_Date__c  = instOfOppTractStrFTR.Cancellation_Date_Tract__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            if(instOfOpp.Year_1_at_Risk__c != null)
                            instOfOppTractStrFTR.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrFTR.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrFTR.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrFTR.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrFTR.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrFTR.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrFTR.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrFTR.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrFTR.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrFTR.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            instOfOppTractStrFTR.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrFTR.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrFTR.Product_Category_Tract__c = 'CSN - FTR';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            ftrDateCheck = true;
                            //instOfOppTractStrFTR.Tract_Implementation_Date__c =  system.today();
                            //instOfOppTractStrFTR.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrFTR.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrFTR.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrFTR.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapIdDeciStraightDGB.ContainsKey(strContNum)){
                            dgbDelete++;
                            instOfOppTractStrDGB.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DGB' +' ' + 'Straightline';
                            instOfOppTractStrDGB.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            instOfOppTractStrDGB.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            instOfOppTractStrDGB.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDGB.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DGB';
                            instOfOppTractStrDGB.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDGB.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDGB.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrDGB.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            if(instOfOpp.Year_1_at_Risk__c !=null)
                            instOfOppTractStrCSN.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDGB.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDGB.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDGB.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDGB.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDGB.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDGB.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDGB.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDGB.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDGB.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDGB.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDGB.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDGB.Product_Category_Tract__c = 'CSN - DGB';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            dgbDateCheck = true;
                            //instOfOppTractStrFTR.Tract_Implementation_Date__c =  system.today();
                            //instOfOppTractStrDGB.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrDGB.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrDGB.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrDGB.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapIdDeciStraightCSN.ContainsKey(strContNum)){
                            csnDelete++;
                            instOfOppTractStrCSN.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN' +' ' + 'Straightline';
                            instOfOppTractStrCSN.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            instOfOppTractStrCSN.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            instOfOppTractStrCSN.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrCSN.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'CSN';
                            instOfOppTractStrCSN.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrCSN.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrCSN.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrCSN.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            if(instOfOpp.Year_1_at_Risk__c != null)
                            instOfOppTractStrCSN.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c !=null)
                            instOfOppTractStrCSN.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrCSN.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrCSN.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrCSN.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrCSN.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrCSN.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrCSN.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrCSN.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrCSN.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrCSN.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrCSN.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrCSN.Product_Category_Tract__c = 'CSN';
                            
                            system.debug('instOfOpp.Send_This_To_Tract__c++'+instOfOpp.Send_This_To_Tract__c);
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            csnDateCheck = true;
                            //instOfOppTractStrCSN.Tract_Implementation_Date__c =  system.today();
                            //instOfOppTractStrCSN.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrCSN.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrCSN.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrCSN.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapIdDeciStraightDPSSLM.ContainsKey(strContNum)){
                            dpsslmDelete++;
                            instOfOppTractStrDPSSLM.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DPS_SLM' +' ' + 'Straightline';
                            instOfOppTractStrDPSSLM.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            instOfOppTractStrDPSSLM.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            instOfOppTractStrDPSSLM.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDPSSLM.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DPSSLM';
                            instOfOppTractStrDPSSLM.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDPSSLM.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDPSSLM.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrDPSSLM.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            if(instOfOpp.Year_1_at_Risk__c != null)
                            instOfOppTractStrDPSSLM.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDPSSLM.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDPSSLM.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDPSSLM.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;       
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDPSSLM.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDPSSLM.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDPSSLM.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDPSSLM.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDPSSLM.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDPSSLM.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDPSSLM.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDPSSLM.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDPSSLM.Product_Category_Tract__c = 'CSN - DPS_SLM';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            dpssDateCheck = true;
                            //instOfOppTractStrDPSSLM.Tract_Implementation_Date__c =  system.today();
                            //instOfOppTractStrDPSSLM.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrDPSSLM.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrDPSSLM.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrDPSSLM.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        system.debug('mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)++++'+mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id));
                        system.debug('instOfOpp.Deal_Year__c++++'+instOfOpp.Deal_Year__c);
                        if(mapOppIdTotalFeeFTR.ContainsKey(instOfOpp.Id)){
                                
                            instOfOppTractStrFTR.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrFTR.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrFTR.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrFTR.Year_1_Agreement__c = '';
                            instOfOppTractStrFTR.Year_1_Start_Date__c = null;
                            instOfOppTractStrFTR.Year_1_End_Date__c = null;
                            
                            instOfOppTractStrFTR.Year_1_Opt_out_Date__c = null;
                            instOfOppTractStrFTR.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapOppIdTotalFeeDGB.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDGB.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDGB.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDGB.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrDGB.Year_1_Agreement__c = '';
                            instOfOppTractStrDGB.Year_1_Start_Date__c = null;
                            instOfOppTractStrDGB.Year_1_End_Date__c = null;
                            
                            instOfOppTractStrDGB.Year_1_Opt_out_Date__c = null;
                            instOfOppTractStrDGB.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrCSN.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrCSN.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrCSN.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrCSN.Year_1_Agreement__c = '';
                            instOfOppTractStrCSN.Year_1_Start_Date__c = null;
                            instOfOppTractStrCSN.Year_1_End_Date__c = null;
                            
                            instOfOppTractStrCSN.Year_1_Opt_out_Date__c = null;
                            instOfOppTractStrCSN.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        if(mapOppIdTotalFeeDPSSLM.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDPSSLM.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDPSSLM.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDPSSLM.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrDPSSLM.Year_1_Agreement__c = '';
                            instOfOppTractStrDPSSLM.Year_1_Start_Date__c = null;
                            instOfOppTractStrDPSSLM.Year_1_End_Date__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_1_Opt_out_Date__c = null;
                            instOfOppTractStrDPSSLM.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c =  null;
                        }
                    }
                    
                    if(instOfOpp.Deal_Year__c == '2'){
                        if(mapIdDeciStraightFTR.ContainsKey(strContNum)){
                            ftrDelete++;
                            instOfOppTractStrFTR.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - FTR' +' ' + 'Straightline';
                            instOfOppTractStrFTR.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrFTR.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrFTR.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrFTR.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'FTR';
                            instOfOppTractStrFTR.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrFTR.Contract_Number_New__c = instOfOpp.Contract_Number_New__c; 
                            instOfOppTractStrFTR.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrFTR.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            //instOfOppTractStrFTR.Tract_Implementation_Date__c  = instOfOppTractStrFTR.Cancellation_Date_Tract__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrFTR.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrFTR.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrFTR.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrFTR.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrFTR.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrFTR.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrFTR.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrFTR.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrFTR.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrFTR.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            instOfOppTractStrFTR.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrFTR.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrFTR.Product_Category_Tract__c = 'CSN - FTR';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            ftrDateCheck = true;
                            //instOfOppTractStrFTR.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrFTR.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrFTR.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrFTR.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapIdDeciStraightDGB.ContainsKey(strContNum)){
                            dgbDelete++;
                            instOfOppTractStrDGB.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DGB' +' ' + 'Straightline';
                            instOfOppTractStrDGB.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrDGB.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrDGB.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDGB.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DGB';
                            instOfOppTractStrDGB.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDGB.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDGB.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrDGB.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c !=null)
                            //instOfOppTractStrCSN.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDGB.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDGB.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDGB.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDGB.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDGB.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDGB.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDGB.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDGB.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDGB.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDGB.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDGB.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDGB.Product_Category_Tract__c = 'CSN - DGB';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            dgbDateCheck = true;
                        }
                        if(mapIdDeciStraightCSN.ContainsKey(strContNum)){
                            csnDelete++;
                            instOfOppTractStrCSN.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN' +' ' + 'Straightline';
                            instOfOppTractStrCSN.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrCSN.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrCSN.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrCSN.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'CSN';
                            instOfOppTractStrCSN.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrCSN.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrCSN.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrCSN.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrCSN.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c !=null)
                            instOfOppTractStrCSN.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrCSN.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrCSN.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrCSN.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrCSN.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrCSN.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrCSN.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrCSN.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrCSN.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrCSN.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrCSN.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrCSN.Product_Category_Tract__c = 'CSN';
                            system.debug('instOfOpp.Send_This_To_Tract__c++'+instOfOpp.Send_This_To_Tract__c);
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            csnDateCheck = true;
                        }
                        if(mapIdDeciStraightDPSSLM.ContainsKey(strContNum)){
                            dpsslmDelete++;
                            instOfOppTractStrDPSSLM.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DPS_SLM' +' ' + 'Straightline';
                            instOfOppTractStrDPSSLM.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrDPSSLM.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrDPSSLM.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDPSSLM.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DPSSLM';
                            instOfOppTractStrDPSSLM.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDPSSLM.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDPSSLM.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrDPSSLM.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrDPSSLM.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDPSSLM.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDPSSLM.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDPSSLM.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDPSSLM.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDPSSLM.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDPSSLM.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDPSSLM.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDPSSLM.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDPSSLM.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDPSSLM.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDPSSLM.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDPSSLM.Product_Category_Tract__c = 'CSN - DPS_SLM';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            dpssDateCheck = true;
                        }
                        if(mapOppIdTotalFeeFTR.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrFTR.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrFTR.Year_2_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrFTR.Year_2_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrFTR.Year_2_Agreement__c = '';
                            instOfOppTractStrFTR.Year_2_Start_Date__c = null;
                            instOfOppTractStrFTR.Year_2_End_Date__c = null;
                            
                            instOfOppTractStrFTR.Year_2_Opt_out_Date__c = null;
                            instOfOppTractStrFTR.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapOppIdTotalFeeDGB.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDGB.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDGB.Year_2_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDGB.Year_2_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrDGB.Year_2_Agreement__c = '';
                            instOfOppTractStrDGB.Year_2_Start_Date__c = null;
                            instOfOppTractStrDGB.Year_2_End_Date__c = null;
                            
                            instOfOppTractStrDGB.Year_2_Opt_out_Date__c = null;
                            instOfOppTractStrDGB.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        system.debug('mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)++++'+mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id));
                        system.debug('instOfOpp.Deal_Year__c++++'+instOfOpp.Deal_Year__c);
                        if(mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrCSN.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrCSN.Year_2_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrCSN.Year_2_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrCSN.Year_2_Agreement__c = '';
                            instOfOppTractStrCSN.Year_2_Start_Date__c = null;
                            instOfOppTractStrCSN.Year_2_End_Date__c = null;
                            
                            instOfOppTractStrCSN.Year_2_Opt_out_Date__c = null;
                            instOfOppTractStrCSN.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapOppIdTotalFeeDPSSLM.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDPSSLM.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDPSSLM.Year_2_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDPSSLM.Year_2_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrDPSSLM.Year_2_Agreement__c = '';
                            instOfOppTractStrDPSSLM.Year_2_Start_Date__c = null;
                            instOfOppTractStrDPSSLM.Year_2_End_Date__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_2_Opt_out_Date__c = null;
                            instOfOppTractStrDPSSLM.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c =  null;
                        }
                    }
                    
                    if(instOfOpp.Deal_Year__c == '3'){
                        if(mapIdDeciStraightFTR.ContainsKey(strContNum)){
                            ftrDelete++;
                            instOfOppTractStrFTR.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - FTR' +' ' + 'Straightline';
                            instOfOppTractStrFTR.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrFTR.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrFTR.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrFTR.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'FTR';
                            instOfOppTractStrFTR.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrFTR.Contract_Number_New__c = instOfOpp.Contract_Number_New__c; 
                            instOfOppTractStrFTR.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrFTR.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            //instOfOppTractStrFTR.Tract_Implementation_Date__c  = instOfOppTractStrFTR.Cancellation_Date_Tract__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrFTR.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrFTR.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrFTR.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrFTR.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrFTR.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrFTR.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrFTR.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrFTR.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrFTR.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrFTR.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            instOfOppTractStrFTR.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrFTR.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrFTR.Product_Category_Tract__c = 'CSN - FTR';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            ftrDateCheck = true;
                            //instOfOppTractStrFTR.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrFTR.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrFTR.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrFTR.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapIdDeciStraightDGB.ContainsKey(strContNum)){
                            dgbDelete++;
                            instOfOppTractStrDGB.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DGB' +' ' + 'Straightline';
                            instOfOppTractStrDGB.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrDGB.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrDGB.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDGB.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DGB';
                            instOfOppTractStrDGB.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDGB.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDGB.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrDGB.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c !=null)
                            //instOfOppTractStrCSN.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDGB.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDGB.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDGB.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDGB.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDGB.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDGB.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDGB.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDGB.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDGB.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDGB.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDGB.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDGB.Product_Category_Tract__c = 'CSN - DGB';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            dgbDateCheck = true;
                        }
                        if(mapIdDeciStraightCSN.ContainsKey(strContNum)){
                            csnDelete++;
                            instOfOppTractStrCSN.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN' +' ' + 'Straightline';
                            instOfOppTractStrCSN.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrCSN.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrCSN.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrCSN.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'CSN';
                            instOfOppTractStrCSN.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrCSN.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrCSN.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrCSN.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrCSN.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c !=null)
                            instOfOppTractStrCSN.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrCSN.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrCSN.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrCSN.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrCSN.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrCSN.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrCSN.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrCSN.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrCSN.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrCSN.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrCSN.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrCSN.Product_Category_Tract__c = 'CSN';
                            system.debug('instOfOpp.Send_This_To_Tract__c++'+instOfOpp.Send_This_To_Tract__c);
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            csnDateCheck = true;
                        }
                        if(mapIdDeciStraightDPSSLM.ContainsKey(strContNum)){
                            dpsslmDelete++;
                            instOfOppTractStrDPSSLM.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DPS_SLM' +' ' + 'Straightline';
                            instOfOppTractStrDPSSLM.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrDPSSLM.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrDPSSLM.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDPSSLM.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DPSSLM';
                            instOfOppTractStrDPSSLM.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDPSSLM.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDPSSLM.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrDPSSLM.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrDPSSLM.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDPSSLM.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDPSSLM.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDPSSLM.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;       
                                    
                            // Clubbed TRACT billing account for CSN
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDPSSLM.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDPSSLM.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDPSSLM.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDPSSLM.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDPSSLM.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDPSSLM.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDPSSLM.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDPSSLM.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDPSSLM.Product_Category_Tract__c = 'CSN - DPS_SLM';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            dpssDateCheck = true;
                        }
                        if(mapOppIdTotalFeeFTR.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrFTR.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrFTR.Year_3_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrFTR.Year_3_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            instOfOppTractStrFTR.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrFTR.Year_3_Agreement__c = '';
                            instOfOppTractStrFTR.Year_3_Start_Date__c = null;
                            instOfOppTractStrFTR.Year_3_End_Date__c = null;
                            
                            instOfOppTractStrFTR.Year_3_Opt_out_Date__c = null;
                            instOfOppTractStrFTR.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        if(mapOppIdTotalFeeDGB.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDGB.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDGB.Year_3_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDGB.Year_3_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            instOfOppTractStrDGB.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrDGB.Year_3_Agreement__c = '';
                            instOfOppTractStrDGB.Year_3_Start_Date__c = null;
                            instOfOppTractStrDGB.Year_3_End_Date__c = null;
                            
                            instOfOppTractStrDGB.Year_3_Opt_out_Date__c = null;
                            instOfOppTractStrDGB.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrCSN.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrCSN.Year_3_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrCSN.Year_3_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrCSN.Year_3_Agreement__c = '';
                            instOfOppTractStrCSN.Year_3_Start_Date__c = null;
                            instOfOppTractStrCSN.Year_3_End_Date__c = null;
                            
                            instOfOppTractStrCSN.Year_3_Opt_out_Date__c = null;
                            instOfOppTractStrCSN.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        if(mapOppIdTotalFeeDPSSLM.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDPSSLM.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDPSSLM.Year_3_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDPSSLM.Year_3_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrDPSSLM.Year_3_Agreement__c = '';
                            instOfOppTractStrDPSSLM.Year_3_Start_Date__c = null;
                            instOfOppTractStrDPSSLM.Year_3_End_Date__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_3_Opt_out_Date__c = null;
                            instOfOppTractStrDPSSLM.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c =  null;
                        }
                    }
                    
                    if(instOfOpp.Deal_Year__c == '4'){
                        if(mapIdDeciStraightFTR.ContainsKey(strContNum)){
                            ftrDelete++;
                            instOfOppTractStrFTR.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - FTR' +' ' + 'Straightline';
                            instOfOppTractStrFTR.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrFTR.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrFTR.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrFTR.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'FTR';
                            instOfOppTractStrFTR.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrFTR.Contract_Number_New__c = instOfOpp.Contract_Number_New__c; 
                            instOfOppTractStrFTR.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrFTR.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            //instOfOppTractStrFTR.Tract_Implementation_Date__c  = instOfOppTractStrFTR.Cancellation_Date_Tract__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrFTR.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrFTR.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrFTR.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrFTR.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrFTR.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrFTR.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrFTR.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrFTR.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrFTR.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrFTR.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            instOfOppTractStrFTR.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrFTR.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrFTR.Product_Category_Tract__c = 'CSN - FTR';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            ftrDateCheck = true;
                            //instOfOppTractStrFTR.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrFTR.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrFTR.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrFTR.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapIdDeciStraightDGB.ContainsKey(strContNum)){
                            dgbDelete++;
                            instOfOppTractStrDGB.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DGB' +' ' + 'Straightline';
                            instOfOppTractStrDGB.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrDGB.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrDGB.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDGB.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DGB';
                            instOfOppTractStrDGB.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDGB.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDGB.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrDGB.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c !=null)
                            //instOfOppTractStrCSN.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDGB.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDGB.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDGB.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDGB.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDGB.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDGB.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDGB.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDGB.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDGB.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDGB.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDGB.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDGB.Product_Category_Tract__c = 'CSN - DGB';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            dgbDateCheck = true;
                        }
                        if(mapIdDeciStraightCSN.ContainsKey(strContNum)){
                            csnDelete++;
                            instOfOppTractStrCSN.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN' +' ' + 'Straightline';
                            instOfOppTractStrCSN.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrCSN.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrCSN.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrCSN.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'CSN';
                            instOfOppTractStrCSN.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrCSN.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrCSN.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrCSN.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrCSN.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c !=null)
                            instOfOppTractStrCSN.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrCSN.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrCSN.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrCSN.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrCSN.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrCSN.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrCSN.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrCSN.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrCSN.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrCSN.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrCSN.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrCSN.Product_Category_Tract__c = 'CSN';
                            system.debug('instOfOpp.Send_This_To_Tract__c++'+instOfOpp.Send_This_To_Tract__c);
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            csnDateCheck = true;
                        }
                        if(mapIdDeciStraightDPSSLM.ContainsKey(strContNum)){
                            dpsslmDelete++;
                            instOfOppTractStrDPSSLM.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DPS_SLM' +' ' + 'Straightline';
                            instOfOppTractStrDPSSLM.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrDPSSLM.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrDPSSLM.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDPSSLM.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DPSSLM';
                            instOfOppTractStrDPSSLM.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDPSSLM.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDPSSLM.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrDPSSLM.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrDPSSLM.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDPSSLM.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDPSSLM.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDPSSLM.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;       
                                    
                            // Clubbed TRACT billing account for CSN
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDPSSLM.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDPSSLM.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDPSSLM.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDPSSLM.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDPSSLM.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDPSSLM.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDPSSLM.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDPSSLM.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDPSSLM.Product_Category_Tract__c = 'CSN - DPS_SLM';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            dpssDateCheck = true;
                        }
                        if(mapOppIdTotalFeeFTR.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrFTR.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrFTR.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrFTR.Year_4_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrFTR.Year_4_Agreement__c = '';
                            instOfOppTractStrFTR.Year_4_Start_Date__c = null;
                            instOfOppTractStrFTR.Year_4_End_Date__c = null;
                            
                            instOfOppTractStrFTR.Year_4_Opt_out_Date__c = null;
                            instOfOppTractStrFTR.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapOppIdTotalFeeDGB.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDGB.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDGB.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDGB.Year_4_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrDGB.Year_4_Agreement__c = '';
                            instOfOppTractStrDGB.Year_4_Start_Date__c = null;
                            instOfOppTractStrDGB.Year_4_End_Date__c = null;
                            
                            instOfOppTractStrDGB.Year_4_Opt_out_Date__c = null;
                            instOfOppTractStrDGB.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrCSN.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrCSN.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrCSN.Year_4_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrCSN.Year_4_Agreement__c = '';
                            instOfOppTractStrCSN.Year_4_Start_Date__c = null;
                            instOfOppTractStrCSN.Year_4_End_Date__c = null;
                            
                            instOfOppTractStrCSN.Year_4_Opt_out_Date__c = null;
                            instOfOppTractStrCSN.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapOppIdTotalFeeDPSSLM.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDPSSLM.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDPSSLM.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDPSSLM.Year_4_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrDPSSLM.Year_4_Agreement__c = '';
                            instOfOppTractStrDPSSLM.Year_4_Start_Date__c = null;
                            instOfOppTractStrDPSSLM.Year_4_End_Date__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_4_Opt_out_Date__c = null;
                            instOfOppTractStrDPSSLM.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c =  null;
                        }
                    }
                    
                    if(instOfOpp.Deal_Year__c == '5'){
                        if(mapIdDeciStraightFTR.ContainsKey(strContNum)){
                            ftrDelete++;
                            instOfOppTractStrFTR.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - FTR' +' ' + 'Straightline';
                            instOfOppTractStrFTR.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrFTR.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrFTR.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrFTR.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'FTR';
                            instOfOppTractStrFTR.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrFTR.Contract_Number_New__c = instOfOpp.Contract_Number_New__c; 
                            instOfOppTractStrFTR.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrFTR.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            //instOfOppTractStrFTR.Tract_Implementation_Date__c  = instOfOppTractStrFTR.Cancellation_Date_Tract__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrFTR.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrFTR.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrFTR.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrFTR.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrFTR.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrFTR.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrFTR.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrFTR.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrFTR.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrFTR.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            instOfOppTractStrFTR.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrFTR.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrFTR.Product_Category_Tract__c = 'CSN - FTR';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            ftrDateCheck = true;
                            //instOfOppTractStrFTR.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                            //instOfOppTractStrFTR.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            //instOfOppTractStrFTR.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            //if(instOfOpp.OptOutDate__c != null)
                            //instOfOppTractStrFTR.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }
                        if(mapIdDeciStraightDGB.ContainsKey(strContNum)){
                            dgbDelete++;
                            instOfOppTractStrDGB.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DGB' +' ' + 'Straightline';
                            instOfOppTractStrDGB.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrDGB.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrDGB.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDGB.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DGB';
                            instOfOppTractStrDGB.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDGB.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDGB.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrDGB.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c !=null)
                            //instOfOppTractStrCSN.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDGB.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDGB.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDGB.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDGB.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDGB.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDGB.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDGB.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDGB.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDGB.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDGB.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDGB.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDGB.Product_Category_Tract__c = 'CSN - DGB';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            dgbDateCheck = true;
                        }
                        if(mapIdDeciStraightCSN.ContainsKey(strContNum)){
                            csnDelete++;
                            instOfOppTractStrCSN.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN' +' ' + 'Straightline';
                            instOfOppTractStrCSN.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrCSN.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrCSN.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrCSN.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'CSN';
                            instOfOppTractStrCSN.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrCSN.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrCSN.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrCSN.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrCSN.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c !=null)
                            instOfOppTractStrCSN.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrCSN.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrCSN.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;      
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrCSN.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrCSN.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrCSN.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrCSN.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrCSN.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrCSN.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrCSN.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrCSN.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrCSN.Product_Category_Tract__c = 'CSN';
                            system.debug('instOfOpp.Send_This_To_Tract__c++'+instOfOpp.Send_This_To_Tract__c);
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            csnDateCheck = true;
                        }
                        if(mapIdDeciStraightDPSSLM.ContainsKey(strContNum)){
                            dpsslmDelete++;
                            instOfOppTractStrDPSSLM.Name = instOfOpp.Product__c +' ' + mapMonth.get(instOfOpp.CloseDate.month()) +' ' + String.valueOf(instOfOpp.CloseDate.year()) +' ' + instOfOpp.New_Type__c +' ' + 'CSN - DPS_SLM' +' ' + 'Straightline';
                            instOfOppTractStrDPSSLM.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                            //instOfOppTractStrDPSSLM.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                            //instOfOppTractStrDPSSLM.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                            instOfOppTractStrDPSSLM.Contract_Number_CSN__c = instOfOpp.Contract_Number_New__c + 'DPSSLM';
                            instOfOppTractStrDPSSLM.Product__c = instOfOpp.Product__c;
                            instOfOppTractStrDPSSLM.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                            instOfOppTractStrDPSSLM.ContractReceived__c = instOfOpp.ContractReceived__c;
                            instOfOppTractStrDPSSLM.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.OptOutDate__c = instOfOpp.OptOutDate__c;
                            
                            //if(instOfOpp.Year_1_at_Risk__c != null)
                            //instOfOppTractStrDPSSLM.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                            
                            if(instOfOpp.Currency__c != null)
                            instOfOppTractStrDPSSLM.Currency__c = instOfOpp.Currency__c;
                            
                            if(instOfOpp.Forex_rate__c != null)
                            instOfOppTractStrDPSSLM.Forex_rate__c = instOfOpp.Forex_rate__c;
                            
                            // Clubbed TRACT billing account for CSN        
                                    
                            if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')      
                            instOfOppTractStrDPSSLM.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;       
                                    
                            // Clubbed TRACT billing account for CSN
                            
                            if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                                instOfOppTractStrDPSSLM.Contract_Total_Tract_Review__c =  mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                            }
                            
                            instOfOppTractStrDPSSLM.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                            instOfOppTractStrDPSSLM.AccountId = instOfOpp.AccountId;
                            instOfOppTractStrDPSSLM.Opp_Type_Classification__c = 'Master Straightline';
                            instOfOppTractStrDPSSLM.StageName = 'Tract';
                            
                            if(instOfOpp.Price_per_lead__c != null)
                            instOfOppTractStrDPSSLM.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                            
                            instOfOppTractStrDPSSLM.CloseDate = instOfOpp.CloseDate;
                            instOfOppTractStrDPSSLM.RecordTypeId = instOfRecType.Id;
                            instOfOppTractStrDPSSLM.Product_Category_Tract__c = 'CSN - DPS_SLM';
                            
                            if(instOfOpp.Send_This_To_Tract__c == false)
                            dpssDateCheck = true;
                        }
                        if(mapOppIdTotalFeeFTR.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrFTR.Year_5_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrFTR.Year_5_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrFTR.Year_5_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrFTR.Year_5_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrFTR.Year_5_Agreement__c = '';
                            instOfOppTractStrFTR.Year_5_Start_Date__c = null;
                            instOfOppTractStrFTR.Year_5_End_Date__c = null;
                            
                            instOfOppTractStrFTR.Year_5_Opt_out_Date__c = null;
                            instOfOppTractStrFTR.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapOppIdTotalFeeDGB.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDGB.Year_5_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDGB.Year_5_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDGB.Year_5_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDGB.Year_5_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrDGB.Year_5_Agreement__c = '';
                            instOfOppTractStrDGB.Year_5_Start_Date__c = null;
                            instOfOppTractStrDGB.Year_5_End_Date__c = null;
                            
                            instOfOppTractStrDGB.Year_5_Opt_out_Date__c = null;
                            instOfOppTractStrDGB.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapOppIdTotalFeeCSN.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrCSN.Year_5_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrCSN.Year_5_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrCSN.Year_5_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrCSN.Year_5_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrCSN.Year_5_Agreement__c = '';
                            instOfOppTractStrCSN.Year_5_Start_Date__c = null;
                            instOfOppTractStrCSN.Year_5_End_Date__c = null;
                            
                            instOfOppTractStrCSN.Year_5_Opt_out_Date__c = null;
                            instOfOppTractStrCSN.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapOppIdTotalFeeDPSSLM.ContainsKey(instOfOpp.Id)){
                            
                            instOfOppTractStrDPSSLM.Year_5_Agreement__c = instOfOpp.Deal_Year__c;
                            instOfOppTractStrDPSSLM.Year_5_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                            instOfOppTractStrDPSSLM.Year_5_End_Date__c = instOfOpp.Opp_End_Date__c;
                            
                            if(instOfOpp.OptOutDate__c != null)
                            instOfOppTractStrDPSSLM.Year_5_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                        }else{
                            instOfOppTractStrDPSSLM.Year_5_Agreement__c = '';
                            instOfOppTractStrDPSSLM.Year_5_Start_Date__c = null;
                            instOfOppTractStrDPSSLM.Year_5_End_Date__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_5_Opt_out_Date__c = null;
                            instOfOppTractStrDPSSLM.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c =  null;
                        }
                    }
                    
                    if(instOfOppTractStrFTR.Opp_Type_Classification__c != null){
                        instOfOppTractStrFTR.Contract_Total_Tract__c = mapIdDeciStraightFTR.get(strContNum);
                        
                        if(mapDeciTotalYear1FTR.containsKey(strContNum)){
                            instOfOppTractStrFTR.Year_1_Value__c = mapDeciTotalYear1FTR.get(strContNum);
                        }else{
                            instOfOppTractStrFTR.Year_1_Value__c = null;
                            instOfOppTractStrFTR.Year_1_Agreement__c = '';
                            instOfOppTractStrFTR.Year_1_Start_Date__c = null;
                            instOfOppTractStrFTR.Year_1_End_Date__c = null;
                            
                            instOfOppTractStrFTR.Year_1_Opt_out_Date__c = null;
                            instOfOppTractStrFTR.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapDeciTotalYear2FTR.containsKey(strContNum)){
                            instOfOppTractStrFTR.Year_2_Value__c = mapDeciTotalYear2FTR.get(strContNum);
                        }else{
                            instOfOppTractStrFTR.Year_2_Value__c = null;
                            
                            instOfOppTractStrFTR.Year_2_Agreement__c = '';
                            instOfOppTractStrFTR.Year_2_Start_Date__c = null;
                            instOfOppTractStrFTR.Year_2_End_Date__c = null;
                            
                            instOfOppTractStrFTR.Year_2_Opt_out_Date__c = null;
                            instOfOppTractStrFTR.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapDeciTotalYear3FTR.containsKey(strContNum)){
                            instOfOppTractStrFTR.Year_3_Value__c = mapDeciTotalYear3FTR.get(strContNum);    
                        }else{
                            instOfOppTractStrFTR.Year_3_Value__c = null;
                            
                            instOfOppTractStrFTR.Year_3_Agreement__c = '';
                            instOfOppTractStrFTR.Year_3_Start_Date__c = null;
                            instOfOppTractStrFTR.Year_3_End_Date__c = null;
                            
                            instOfOppTractStrFTR.Year_3_Opt_out_Date__c = null;
                            instOfOppTractStrFTR.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapDeciTotalYear4FTR.containsKey(strContNum)){
                            instOfOppTractStrFTR.Year_4_Value__c = mapDeciTotalYear4FTR.get(strContNum);    
                        }else{
                            instOfOppTractStrFTR.Year_4_Value__c = null;
                            
                            instOfOppTractStrFTR.Year_4_Agreement__c = '';
                            instOfOppTractStrFTR.Year_4_Start_Date__c = null;
                            instOfOppTractStrFTR.Year_4_End_Date__c = null;
                            
                            instOfOppTractStrFTR.Year_4_Opt_out_Date__c = null;
                            instOfOppTractStrFTR.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapDeciTotalYear5FTR.containsKey(strContNum)){
                            instOfOppTractStrFTR.Year_5_Value__c = mapDeciTotalYear5FTR.get(strContNum);    
                        }else{
                            instOfOppTractStrFTR.Year_5_Value__c = null;
                            
                            instOfOppTractStrFTR.Year_5_Agreement__c = '';
                            instOfOppTractStrFTR.Year_5_Start_Date__c = null;
                            instOfOppTractStrFTR.Year_5_End_Date__c = null;
                            
                            instOfOppTractStrFTR.Year_5_Opt_out_Date__c = null;
                            instOfOppTractStrFTR.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        //lstOppTractIns.add(instOfOppTractStrFTR);
                    }
                    
                    if(instOfOppTractStrCSN.Opp_Type_Classification__c != null){
                        instOfOppTractStrCSN.Contract_Total_Tract__c = mapIdDeciStraightCSN.get(strContNum);
                        system.debug('mapDeciTotalYear1CSN.containsKey(strContNum)++'+mapDeciTotalYear1CSN.containsKey(strContNum));
                        if(mapDeciTotalYear1CSN.containsKey(strContNum)){
                            instOfOppTractStrCSN.Year_1_Value__c = mapDeciTotalYear1CSN.get(strContNum);
                        }else{
                            instOfOppTractStrCSN.Year_1_Value__c = null;
                            
                            instOfOppTractStrCSN.Year_1_Agreement__c = '';
                            instOfOppTractStrCSN.Year_1_Start_Date__c = null;
                            instOfOppTractStrCSN.Year_1_End_Date__c = null;
                            
                            instOfOppTractStrCSN.Year_1_Opt_out_Date__c = null;
                            instOfOppTractStrCSN.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapDeciTotalYear2CSN.containsKey(strContNum)){
                            instOfOppTractStrCSN.Year_2_Value__c = mapDeciTotalYear2CSN.get(strContNum);    
                        }else{
                            instOfOppTractStrCSN.Year_2_Value__c = null;
                            instOfOppTractStrCSN.Year_2_Value__c = null;
                            instOfOppTractStrCSN.Year_2_Agreement__c = '';
                            instOfOppTractStrCSN.Year_2_Start_Date__c = null;
                            instOfOppTractStrCSN.Year_2_End_Date__c = null;
                            
                            instOfOppTractStrCSN.Year_2_Opt_out_Date__c = null;
                            instOfOppTractStrCSN.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        
                        if(mapDeciTotalYear3CSN.containsKey(strContNum)){
                            instOfOppTractStrCSN.Year_3_Value__c = mapDeciTotalYear3CSN.get(strContNum);    
                        }else{
                            instOfOppTractStrCSN.Year_3_Value__c = null;
                            instOfOppTractStrCSN.Year_3_Value__c = null;
                            instOfOppTractStrCSN.Year_3_Agreement__c = '';
                            instOfOppTractStrCSN.Year_3_Start_Date__c = null;
                            instOfOppTractStrCSN.Year_3_End_Date__c = null;
                            
                            instOfOppTractStrCSN.Year_3_Opt_out_Date__c = null;
                            instOfOppTractStrCSN.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        
                        if(mapDeciTotalYear4CSN.containsKey(strContNum)){
                            instOfOppTractStrCSN.Year_4_Value__c = mapDeciTotalYear4CSN.get(strContNum);    
                        }else{
                            instOfOppTractStrCSN.Year_4_Value__c = null;
                            
                            instOfOppTractStrCSN.Year_4_Agreement__c = '';
                            instOfOppTractStrCSN.Year_4_Start_Date__c = null;
                            instOfOppTractStrCSN.Year_4_End_Date__c = null;
                            
                            instOfOppTractStrCSN.Year_4_Opt_out_Date__c = null;
                            instOfOppTractStrCSN.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapDeciTotalYear5CSN.containsKey(strContNum)){
                            instOfOppTractStrCSN.Year_5_Value__c = mapDeciTotalYear5CSN.get(strContNum);    
                        }else{
                            instOfOppTractStrCSN.Year_5_Value__c = null;
                            
                            instOfOppTractStrCSN.Year_5_Value__c = null;
                            instOfOppTractStrCSN.Year_5_Agreement__c = '';
                            instOfOppTractStrCSN.Year_5_Start_Date__c = null;
                            instOfOppTractStrCSN.Year_5_End_Date__c = null;
                            
                            instOfOppTractStrCSN.Year_5_Opt_out_Date__c = null;
                            instOfOppTractStrCSN.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        
                        //lstOppTractIns.add(instOfOppTractStrCSN);
                    }
                    
                    if(instOfOppTractStrDGB.Opp_Type_Classification__c != null){
                        instOfOppTractStrDGB.Contract_Total_Tract__c = mapIdDeciStraightDGB.get(strContNum);
                        
                        if(mapDeciTotalYear1DGB.containsKey(strContNum)){
                            instOfOppTractStrDGB.Year_1_Value__c = mapDeciTotalYear1DGB.get(strContNum);    
                        }else{
                            instOfOppTractStrDGB.Year_1_Value__c = null;
                            instOfOppTractStrDGB.Year_1_Agreement__c = '';
                            instOfOppTractStrDGB.Year_1_Start_Date__c = null;
                            instOfOppTractStrDGB.Year_1_End_Date__c = null;
                            
                            instOfOppTractStrDGB.Year_1_Opt_out_Date__c = null;
                            instOfOppTractStrDGB.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        
                        if(mapDeciTotalYear2DGB.containsKey(strContNum)){
                            instOfOppTractStrDGB.Year_2_Value__c = mapDeciTotalYear2DGB.get(strContNum);    
                        }else{
                            instOfOppTractStrDGB.Year_2_Value__c = null;
                            instOfOppTractStrDGB.Year_2_Value__c = null;
                            instOfOppTractStrDGB.Year_2_Agreement__c = '';
                            instOfOppTractStrDGB.Year_2_Start_Date__c = null;
                            instOfOppTractStrDGB.Year_2_End_Date__c = null;
                            
                            instOfOppTractStrDGB.Year_2_Opt_out_Date__c = null;
                            instOfOppTractStrDGB.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        
                        if(mapDeciTotalYear3DGB.containsKey(strContNum)){
                            instOfOppTractStrDGB.Year_3_Value__c = mapDeciTotalYear3DGB.get(strContNum);    
                        }else{
                            instOfOppTractStrDGB.Year_3_Value__c = null;
                            
                            instOfOppTractStrDGB.Year_3_Value__c = null;
                            instOfOppTractStrDGB.Year_3_Agreement__c = '';
                            instOfOppTractStrDGB.Year_3_Start_Date__c = null;
                            instOfOppTractStrDGB.Year_3_End_Date__c = null;
                            
                            instOfOppTractStrDGB.Year_3_Opt_out_Date__c = null;
                            instOfOppTractStrDGB.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        
                        if(mapDeciTotalYear4DGB.containsKey(strContNum)){
                            instOfOppTractStrDGB.Year_4_Value__c = mapDeciTotalYear4DGB.get(strContNum);    
                        }else{
                            instOfOppTractStrDGB.Year_4_Value__c = null;
                            
                            instOfOppTractStrDGB.Year_4_Agreement__c = '';
                            instOfOppTractStrDGB.Year_4_Start_Date__c = null;
                            instOfOppTractStrDGB.Year_4_End_Date__c = null;
                            
                            instOfOppTractStrDGB.Year_4_Opt_out_Date__c = null;
                            instOfOppTractStrDGB.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapDeciTotalYear5DGB.containsKey(strContNum)){
                            instOfOppTractStrDGB.Year_5_Value__c = mapDeciTotalYear5DGB.get(strContNum);    
                        }else{
                            instOfOppTractStrDGB.Year_5_Value__c = null;
                            
                            instOfOppTractStrDGB.Year_5_Agreement__c = '';
                            instOfOppTractStrDGB.Year_5_Start_Date__c = null;
                            instOfOppTractStrDGB.Year_5_End_Date__c = null;
                            
                            instOfOppTractStrDGB.Year_5_Opt_out_Date__c = null;
                            instOfOppTractStrDGB.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        //lstOppTractIns.add(instOfOppTractStrDGB);
                    }
                    
                    if(instOfOppTractStrDPSSLM.Opp_Type_Classification__c != null){
                        instOfOppTractStrDPSSLM.Contract_Total_Tract__c = mapIdDeciStraightDPSSLM.get(strContNum);
                        
                        if(mapDeciTotalYear1DPSSLM.containsKey(strContNum)){
                            instOfOppTractStrDPSSLM.Year_1_Value__c = mapDeciTotalYear1DPSSLM.get(strContNum);  
                        }else{
                            instOfOppTractStrDPSSLM.Year_1_Value__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_1_Agreement__c = '';
                            instOfOppTractStrDPSSLM.Year_1_Start_Date__c = null;
                            instOfOppTractStrDPSSLM.Year_1_End_Date__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_1_Opt_out_Date__c = null;
                            instOfOppTractStrDPSSLM.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        
                        if(mapDeciTotalYear2DPSSLM.containsKey(strContNum)){
                            instOfOppTractStrDPSSLM.Year_2_Value__c = mapDeciTotalYear2DPSSLM.get(strContNum);  
                        }else{
                            instOfOppTractStrDPSSLM.Year_2_Value__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_2_Agreement__c = '';
                            instOfOppTractStrDPSSLM.Year_2_Start_Date__c = null;
                            instOfOppTractStrDPSSLM.Year_2_End_Date__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_2_Opt_out_Date__c = null;
                            instOfOppTractStrDPSSLM.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapDeciTotalYear3DPSSLM.containsKey(strContNum)){
                            instOfOppTractStrDPSSLM.Year_3_Value__c = mapDeciTotalYear3DPSSLM.get(strContNum);
                        }else{
                            instOfOppTractStrDPSSLM.Year_3_Value__c = null; 
                            
                            instOfOppTractStrDPSSLM.Year_3_Agreement__c = '';
                            instOfOppTractStrDPSSLM.Year_3_Start_Date__c = null;
                            instOfOppTractStrDPSSLM.Year_3_End_Date__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_3_Opt_out_Date__c = null;
                            instOfOppTractStrDPSSLM.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        
                        if(mapDeciTotalYear4DPSSLM.containsKey(strContNum)){
                            instOfOppTractStrDPSSLM.Year_4_Value__c = mapDeciTotalYear4DPSSLM.get(strContNum);  
                        }else{
                            instOfOppTractStrDPSSLM.Year_4_Value__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_4_Agreement__c = '';
                            instOfOppTractStrDPSSLM.Year_4_Start_Date__c = null;
                            instOfOppTractStrDPSSLM.Year_4_End_Date__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_4_Opt_out_Date__c = null;
                            instOfOppTractStrDPSSLM.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        if(mapDeciTotalYear5DPSSLM.containsKey(strContNum)){
                            instOfOppTractStrDPSSLM.Year_5_Value__c = mapDeciTotalYear5DPSSLM.get(strContNum);  
                        }else{
                            instOfOppTractStrDPSSLM.Year_5_Value__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_5_Agreement__c = '';
                            instOfOppTractStrDPSSLM.Year_5_Start_Date__c = null;
                            instOfOppTractStrDPSSLM.Year_5_End_Date__c = null;
                            
                            instOfOppTractStrDPSSLM.Year_5_Opt_out_Date__c = null;
                            instOfOppTractStrDPSSLM.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c =  null;
                        }
                        
                        
                        //lstOppTractIns.add(instOfOppTractStrDPSSLM);
                    }
                }
                
                system.debug(ftrCheck);
                system.debug(csnCheck);
                system.debug(dgbCheck);
                system.debug(dpsslmCheck);
                system.debug(instOfOppTractStrFTR.Opp_Type_Classification__c);
                system.debug(instOfOppTractStrCSN.Opp_Type_Classification__c);
                system.debug(instOfOppTractStrDGB.Opp_Type_Classification__c);
                system.debug(instOfOppTractStrDPSSLM.Opp_Type_Classification__c);
                system.debug(ftrDelete);
                system.debug(csnDelete);
                system.debug(dgbDelete);
                system.debug(dpsslmDelete);
                List<Date> lstDateCSN = new List<Date>();
                List<Date> lstDateCSNEnd = new List<Date>();
                
                system.debug(ftrDateCheck);
                system.debug(dgbDateCheck);
                system.debug(csnDateCheck);
                system.debug(dpssDateCheck);
                if(ftrDateCheck || dgbDateCheck || csnDateCheck || dpssDateCheck){
                    instOfOppTractStrFTR.Tract_Implementation_Date__c = system.today();
                    instOfOppTractStrCSN.Tract_Implementation_Date__c = system.today();
                    instOfOppTractStrDGB.Tract_Implementation_Date__c = system.today();
                    instOfOppTractStrDPSSLM.Tract_Implementation_Date__c = system.today();
                }
                if(instOfOppTractStrFTR.Opp_Type_Classification__c !=null && ftrCheck > 0 && ftrDelete > 0){
                    
                    lstDateCSN = new List<Date>();
                    if(instOfOppTractStrFTR.Year_1_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrFTR.Year_1_Start_Date__c);
                    if(instOfOppTractStrFTR.Year_2_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrFTR.Year_2_Start_Date__c);
                    if(instOfOppTractStrFTR.Year_3_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrFTR.Year_3_Start_Date__c);
                    if(instOfOppTractStrFTR.Year_4_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrFTR.Year_4_Start_Date__c);
                    if(instOfOppTractStrFTR.Year_5_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrFTR.Year_5_Start_Date__c);
                    
                    if(lstDateCSN.size() > 0){
                        instOfOppTractStrFTR.Year_1_Start_Date__c = lstDateCSN[0];
                        instOfOppTractStrFTR.ContractStartDate__c = lstDateCSN[0];
                    }
                    
                    lstDateCSNEnd = new List<Date>();
                    
                    if(instOfOppTractStrFTR.Year_5_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrFTR.Year_5_End_Date__c);
                    if(instOfOppTractStrFTR.Year_4_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrFTR.Year_4_End_Date__c);
                    if(instOfOppTractStrFTR.Year_3_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrFTR.Year_3_End_Date__c);
                    if(instOfOppTractStrFTR.Year_2_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrFTR.Year_2_End_Date__c);
                    if(instOfOppTractStrFTR.Year_1_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrFTR.Year_1_End_Date__c);
                    
                    if(lstDateCSNEnd.size()>0){
                        lstDateCSNEnd.sort();
                        Integer intSizeOfList =  lstDateCSNEnd.size(); 
                        instOfOppTractStrFTR.ContractEndDate__c = lstDateCSNEnd[intSizeOfList - 1];
                    }
                    
                    lstOppTractUpdCSN.add(instOfOppTractStrFTR);
                }else if(instOfOppTractStrFTR.Opp_Type_Classification__c !=null && ftrCheck == 0 && ftrDelete > 0){
                    
                    lstDateCSN = new List<Date>();
                    if(instOfOppTractStrFTR.Year_1_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrFTR.Year_1_Start_Date__c);
                    if(instOfOppTractStrFTR.Year_2_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrFTR.Year_2_Start_Date__c);
                    if(instOfOppTractStrFTR.Year_3_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrFTR.Year_3_Start_Date__c);
                    if(instOfOppTractStrFTR.Year_4_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrFTR.Year_4_Start_Date__c);
                    if(instOfOppTractStrFTR.Year_5_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrFTR.Year_5_Start_Date__c);
                    
                    if(lstDateCSN.size() > 0){
                        instOfOppTractStrFTR.Year_1_Start_Date__c = lstDateCSN[0];
                        instOfOppTractStrFTR.ContractStartDate__c = lstDateCSN[0];
                    }
                    
                    lstDateCSNEnd = new List<Date>();
                    
                    if(instOfOppTractStrFTR.Year_5_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrFTR.Year_5_End_Date__c);
                    if(instOfOppTractStrFTR.Year_4_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrFTR.Year_4_End_Date__c);
                    if(instOfOppTractStrFTR.Year_3_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrFTR.Year_3_End_Date__c);
                    if(instOfOppTractStrFTR.Year_2_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrFTR.Year_2_End_Date__c);
                    if(instOfOppTractStrFTR.Year_1_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrFTR.Year_1_End_Date__c);
                    
                    if(lstDateCSNEnd.size()>0){
                        lstDateCSNEnd.sort();
                        Integer intSizeOfList =  lstDateCSNEnd.size(); 
                        instOfOppTractStrFTR.ContractEndDate__c = lstDateCSNEnd[intSizeOfList - 1];
                    }
                    
                    lstOppTractInsert.add(instOfOppTractStrFTR);
                    system.debug(lstOppTractInsert);
                }else if(instOfOppTractStrFTR.Opp_Type_Classification__c !=null && ftrCheck > 0 && ftrDelete == 0){
                    lstOppTractdelete.add(instOfOppTractStrFTR);
                }
                
                if(instOfOppTractStrCSN.Opp_Type_Classification__c !=null && csnCheck >0 && csnDelete > 0){
                    lstDateCSN = new List<Date>();
                    if(instOfOppTractStrCSN.Year_1_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrCSN.Year_1_Start_Date__c);
                    if(instOfOppTractStrCSN.Year_2_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrCSN.Year_2_Start_Date__c);
                    if(instOfOppTractStrCSN.Year_3_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrCSN.Year_3_Start_Date__c);
                    if(instOfOppTractStrCSN.Year_4_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrCSN.Year_4_Start_Date__c);
                    if(instOfOppTractStrCSN.Year_5_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrCSN.Year_5_Start_Date__c);
                    
                    if(lstDateCSN.size() > 0){
                        instOfOppTractStrCSN.Year_1_Start_Date__c = lstDateCSN[0];
                        instOfOppTractStrCSN.ContractStartDate__c = lstDateCSN[0];
                    }
                    
                    lstDateCSNEnd = new List<Date>();
                    
                    if(instOfOppTractStrCSN.Year_5_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrCSN.Year_5_End_Date__c);
                    if(instOfOppTractStrCSN.Year_4_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrCSN.Year_4_End_Date__c);
                    if(instOfOppTractStrCSN.Year_3_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrCSN.Year_3_End_Date__c);
                    if(instOfOppTractStrCSN.Year_2_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrCSN.Year_2_End_Date__c);
                    if(instOfOppTractStrCSN.Year_1_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrCSN.Year_1_End_Date__c);
                    
                    if(lstDateCSNEnd.size()>0){
                        lstDateCSNEnd.sort();
                        Integer intSizeOfList =  lstDateCSNEnd.size(); 
                        instOfOppTractStrCSN.ContractEndDate__c = lstDateCSNEnd[intSizeOfList - 1];
                    }
                    lstOppTractUpdCSN.add(instOfOppTractStrCSN);   
                }else if(instOfOppTractStrCSN.Opp_Type_Classification__c !=null && csnCheck == 0 && csnDelete > 0){
                    
                    lstDateCSN = new List<Date>();
                    if(instOfOppTractStrCSN.Year_1_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrCSN.Year_1_Start_Date__c);
                    if(instOfOppTractStrCSN.Year_2_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrCSN.Year_2_Start_Date__c);
                    if(instOfOppTractStrCSN.Year_3_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrCSN.Year_3_Start_Date__c);
                    if(instOfOppTractStrCSN.Year_4_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrCSN.Year_4_Start_Date__c);
                    if(instOfOppTractStrCSN.Year_5_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrCSN.Year_5_Start_Date__c);
                    
                    if(lstDateCSN.size() > 0){
                        instOfOppTractStrCSN.Year_1_Start_Date__c = lstDateCSN[0];
                        instOfOppTractStrCSN.ContractStartDate__c = lstDateCSN[0];
                    }
                    
                    lstDateCSNEnd = new List<Date>();
                    
                    if(instOfOppTractStrCSN.Year_5_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrCSN.Year_5_End_Date__c);
                    if(instOfOppTractStrCSN.Year_4_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrCSN.Year_4_End_Date__c);
                    if(instOfOppTractStrCSN.Year_3_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrCSN.Year_3_End_Date__c);
                    if(instOfOppTractStrCSN.Year_2_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrCSN.Year_2_End_Date__c);
                    if(instOfOppTractStrCSN.Year_1_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrCSN.Year_1_End_Date__c);
                    
                    if(lstDateCSNEnd.size()>0){
                        lstDateCSNEnd.sort();
                        Integer intSizeOfList =  lstDateCSNEnd.size(); 
                        instOfOppTractStrCSN.ContractEndDate__c = lstDateCSNEnd[intSizeOfList - 1];
                    }
                    
                    lstOppTractInsert.add(instOfOppTractStrCSN);
                    system.debug(lstOppTractInsert);
                }else if(instOfOppTractStrCSN.Opp_Type_Classification__c !=null && csnCheck > 0 && csnDelete == 0){
                    lstOppTractdelete.add(instOfOppTractStrCSN);
                }
                
                
                if(instOfOppTractStrDGB.Opp_Type_Classification__c !=null && dgbCheck > 0 && dgbDelete > 0){
                    lstDateCSN = new List<Date>();
                    if(instOfOppTractStrDGB.Year_1_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDGB.Year_1_Start_Date__c);
                    if(instOfOppTractStrDGB.Year_2_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDGB.Year_2_Start_Date__c);
                    if(instOfOppTractStrDGB.Year_3_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDGB.Year_3_Start_Date__c);
                    if(instOfOppTractStrDGB.Year_4_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDGB.Year_4_Start_Date__c);
                    if(instOfOppTractStrDGB.Year_5_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDGB.Year_5_Start_Date__c);
                    
                    if(lstDateCSN.size() > 0){
                        instOfOppTractStrDGB.Year_1_Start_Date__c = lstDateCSN[0];
                        instOfOppTractStrDGB.ContractStartDate__c = lstDateCSN[0];
                    }
                    
                    lstDateCSNEnd = new List<Date>();
                    
                    if(instOfOppTractStrDGB.Year_5_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDGB.Year_5_End_Date__c);
                    if(instOfOppTractStrDGB.Year_4_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDGB.Year_4_End_Date__c);
                    if(instOfOppTractStrDGB.Year_3_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDGB.Year_3_End_Date__c);
                    if(instOfOppTractStrDGB.Year_2_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDGB.Year_2_End_Date__c);
                    if(instOfOppTractStrDGB.Year_1_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDGB.Year_1_End_Date__c);
                    
                    if(lstDateCSNEnd.size()>0){
                        lstDateCSNEnd.sort();
                        Integer intSizeOfList =  lstDateCSNEnd.size(); 
                        instOfOppTractStrDGB.ContractEndDate__c = lstDateCSNEnd[intSizeOfList - 1];
                    }
                    lstOppTractUpdCSN.add(instOfOppTractStrDGB);   
                }else if(instOfOppTractStrDGB.Opp_Type_Classification__c !=null && dgbCheck == 0 && dgbDelete > 0){
                    
                    lstDateCSN = new List<Date>();
                    if(instOfOppTractStrDGB.Year_1_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDGB.Year_1_Start_Date__c);
                    if(instOfOppTractStrDGB.Year_2_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDGB.Year_2_Start_Date__c);
                    if(instOfOppTractStrDGB.Year_3_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDGB.Year_3_Start_Date__c);
                    if(instOfOppTractStrDGB.Year_4_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDGB.Year_4_Start_Date__c);
                    if(instOfOppTractStrDGB.Year_5_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDGB.Year_5_Start_Date__c);
                    
                    if(lstDateCSN.size() > 0){
                        instOfOppTractStrDGB.Year_1_Start_Date__c = lstDateCSN[0];
                        instOfOppTractStrDGB.ContractStartDate__c = lstDateCSN[0];
                    }
                    
                    lstDateCSNEnd = new List<Date>();
                    
                    if(instOfOppTractStrDGB.Year_5_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDGB.Year_5_End_Date__c);
                    if(instOfOppTractStrDGB.Year_4_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDGB.Year_4_End_Date__c);
                    if(instOfOppTractStrDGB.Year_3_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDGB.Year_3_End_Date__c);
                    if(instOfOppTractStrDGB.Year_2_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDGB.Year_2_End_Date__c);
                    if(instOfOppTractStrDGB.Year_1_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDGB.Year_1_End_Date__c);
                    
                    if(lstDateCSNEnd.size()>0){
                        lstDateCSNEnd.sort();
                        Integer intSizeOfList =  lstDateCSNEnd.size(); 
                        instOfOppTractStrDGB.ContractEndDate__c = lstDateCSNEnd[intSizeOfList - 1];
                    }
                    lstOppTractInsert.add(instOfOppTractStrDGB);
                }else if(instOfOppTractStrDGB.Opp_Type_Classification__c !=null && dgbCheck > 0 && dgbDelete == 0){
                    lstOppTractdelete.add(instOfOppTractStrDGB);
                }
                
                
                if(instOfOppTractStrDPSSLM.Opp_Type_Classification__c !=null && dpsslmCheck > 0 && dpsslmDelete > 0){
                    lstDateCSN = new List<Date>();
                    if(instOfOppTractStrDPSSLM.Year_1_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDPSSLM.Year_1_Start_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_2_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDPSSLM.Year_2_Start_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_3_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDPSSLM.Year_3_Start_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_4_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDPSSLM.Year_4_Start_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_5_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDPSSLM.Year_5_Start_Date__c);
                    
                    if(lstDateCSN.size() > 0){
                        instOfOppTractStrDPSSLM.Year_1_Start_Date__c = lstDateCSN[0];
                        instOfOppTractStrDPSSLM.ContractStartDate__c = lstDateCSN[0];
                    }
                    
                    lstDateCSNEnd = new List<Date>();
                    
                    if(instOfOppTractStrDPSSLM.Year_5_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDPSSLM.Year_5_End_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_4_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDPSSLM.Year_4_End_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_3_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDPSSLM.Year_3_End_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_2_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDPSSLM.Year_2_End_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_1_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDPSSLM.Year_1_End_Date__c);
                    
                    if(lstDateCSNEnd.size()>0){
                        lstDateCSNEnd.sort();
                        Integer intSizeOfList =  lstDateCSNEnd.size(); 
                        instOfOppTractStrDPSSLM.ContractEndDate__c = lstDateCSNEnd[intSizeOfList - 1];
                    }
                    
                    lstOppTractUpdCSN.add(instOfOppTractStrDPSSLM);    
                }else if(instOfOppTractStrDPSSLM.Opp_Type_Classification__c !=null && dpsslmCheck == 0 && dpsslmDelete > 0){
                    
                    lstDateCSN = new List<Date>();
                    if(instOfOppTractStrDPSSLM.Year_1_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDPSSLM.Year_1_Start_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_2_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDPSSLM.Year_2_Start_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_3_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDPSSLM.Year_3_Start_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_4_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDPSSLM.Year_4_Start_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_5_Start_Date__c != null)
                    lstDateCSN.add(instOfOppTractStrDPSSLM.Year_5_Start_Date__c);
                    
                    if(lstDateCSN.size() > 0){
                        instOfOppTractStrDPSSLM.Year_1_Start_Date__c = lstDateCSN[0];
                        instOfOppTractStrDPSSLM.ContractStartDate__c = lstDateCSN[0];
                    }
                    
                    lstDateCSNEnd = new List<Date>();
                    
                    if(instOfOppTractStrDPSSLM.Year_5_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDPSSLM.Year_5_End_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_4_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDPSSLM.Year_4_End_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_3_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDPSSLM.Year_3_End_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_2_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDPSSLM.Year_2_End_Date__c);
                    if(instOfOppTractStrDPSSLM.Year_1_End_Date__c != null)
                    lstDateCSNEnd.add(instOfOppTractStrDPSSLM.Year_1_End_Date__c);
                    
                    if(lstDateCSNEnd.size()>0){
                        lstDateCSNEnd.sort();
                        Integer intSizeOfList =  lstDateCSNEnd.size(); 
                        instOfOppTractStrDPSSLM.ContractEndDate__c = lstDateCSNEnd[intSizeOfList - 1];
                    }
                    lstOppTractInsert.add(instOfOppTractStrDPSSLM);
                }else if(instOfOppTractStrDPSSLM.Opp_Type_Classification__c !=null && dpsslmCheck > 0 && dpsslmDelete == 0){
                    lstOppTractdelete.add(instOfOppTractStrDPSSLM);
                }
                
                system.debug('lstOppTractdelete+++'+lstOppTractdelete);
            }else{
            //For CSN
            Opportunity instOfpp = lstOpp[0];
            //Opportunity instOfppSec = lstOpp[1];
                for(Opportunity instOfOpp : mapOppWithMaster.get(strContNum)){
                    if(!mapOfMasterOpp.ContainsKey(instOfOpp.Id)){
                        if(instOfOpp.Deal_Year__c == '1'){
                            
                            //if(instOfOpp.Opp_Type_Classification__c == 'Master Straightline'){
                                system.debug('instOfOpp.New_Type__c'+instOfOpp.New_Type__c);
                                instOfpp.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                                instOfpp.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                                instOfpp.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                                instOfpp.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                                instOfpp.Product__c = instOfOpp.Product__c;
                                instOfpp.OptOutDate__c = instOfOpp.OptOutDate__c;
                                instOfpp.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                                instOfpp.Currency__c = instOfOpp.Currency__c;
                                instOfpp.Forex_rate__c = instOfOpp.Forex_rate__c;
                                instOfpp.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                                instOfpp.AccountId = instOfOpp.AccountId;
                                instOfpp.Opp_Type_Classification__c = 'Master Straightline';
                                instOfpp.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                                instOfpp.CloseDate = instOfOpp.CloseDate;
                                instOfpp.Product_Category_Tract__c = instOfOpp.Product_Category__c;
                                instOfpp.ContractReceived__c = instOfOpp.ContractReceived__c;
                                instOfpp.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                                
                                if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')
                                instOfpp.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;
                                
                                oppNameStr = mapMonth.get(instOfOpp.CloseDate.month())+' ' + String.valueOf(instOfOpp.CloseDate.year());
                            //}
                            //if(instOfOpp.Opp_Type_Classification__c == 'Master Milestone'){
                                //instOfppSec.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                                //instOfppSec.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                                //instOfppSec.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                                //instOfppSec.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                                //instOfppSec.Product__c = instOfOpp.Product__c;
                                //instOfppSec.OptOutDate__c = instOfOpp.OptOutDate__c;
                                //instOfppSec.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                                //instOfppSec.Currency__c = instOfOpp.Currency__c;
                                //instOfppSec.Forex_rate__c = instOfOpp.Forex_rate__c;
                                //instOfppSec.AccountId = instOfOpp.AccountId;
                                //instOfppSec.Opp_Type_Classification__c = 'Master Milestone';
                                //instOfppSec.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                                //instOfppSec.CloseDate = instOfOpp.CloseDate;
                                //instOfppSec.Product_Category_Tract__c = instOfOpp.Product_Category__c;
                            //}
                        }
                        if(instOfOpp.MaintenanceFee__c != null){
                            maintenanceFee = maintenanceFee + instOfOpp.MaintenanceFee__c;  
                        }
                        if(instOfOpp.New_Amount__c != null){
                            usagePackageFee = usagePackageFee + instOfOpp.New_Amount__c;
                        }
                        if(instOfOpp.Discount__c != null){
                            Discount = Discount + instOfOpp.Discount__c; 
                        }
                        if(instOfOpp.Convinience_Fee__c != null){
                            convenienceFee = convenienceFee + instOfOpp.Convinience_Fee__c; 
                        }
                        if(instOfOpp.of_Leads_Purchased__c != null){
                            numOfleadP =  numOfleadP + instOfOpp.of_Leads_Purchased__c;
                        }
                        if(instOfOpp.Events__c != null){
                            numOfEvents = numOfEvents + instOfOpp.Events__c;
                        }
                        if(instOfOpp.Price_Adjustment__c != null){
                            intPrceAdj = intPrceAdj + instOfOpp.Price_Adjustment__c;
                        }
                        if(instOfOpp.Counted_sales_Cancellation_Value__c != null){
                            CancellationAmt =  CancellationAmt  + instOfOpp.Counted_sales_Cancellation_Value__c;
                        }
                        if(instOfOpp.New_Contract_Total__c != null){
                            cntTotalReview = cntTotalReview + instOfOpp.New_Contract_Total__c;
                        }
                        
                        if(instOfOpp.Deal_Year__c != null){
                            if(instOfOpp.Deal_Year__c == '1'){
                                mapDealYearStr.put(instOfOpp.Deal_Year__c,instOfOpp.Deal_Year__c);
                                instOfpp.Year_1_Contract_Type__c = instOfOpp.New_Type__c;
                                //if(instOfOpp.Value__c != null){
                                
                                Double intTotal = 0;
                                if(instOfOpp.MaintenanceFee__c != null){
                                    intTotal = instOfOpp.MaintenanceFee__c;
                                }
                                if(instOfOpp.New_Amount__c != null){
                                    intTotal = intTotal + instOfOpp.New_Amount__c;
                                }
                                if(instOfOpp.Convinience_Fee__c != null){
                                    intTotal = intTotal + instOfOpp.Convinience_Fee__c;
                                }
                                if(mapOppIdFeat.containsKey(instOfOpp.Id)){
                                    intTotal = intTotal + mapOppIdFeat.get(instOfOpp.Id);
                                }
                                if(instOfOpp.Discount__c != null){
                                    intTotal = intTotal - instOfOpp.Discount__c;
                                }
                                if(instOfOpp.Price_Adjustment__c != null){
                                    intTotal = intTotal + instOfOpp.Price_Adjustment__c;
                                }
                                
                                intContYear1Total = intContYear1Total + intTotal;
                                
                                //Changes related to selected opps movement.
                                
                                //Changes related to selected opps movement.
                                
                                //Adjusting the cancellation amount
                                if(instOfOpp.Counted_sales_Cancellation_Value__c != null)
                                intContYear1Total = intContYear1Total - instOfOpp.Counted_sales_Cancellation_Value__c;
                                /*if(instOfOpp.Cancellation_Date_Tract__c != null){
                                    if(dateCancelYear1 == null){
                                        dateCancelYear1 = instOfOpp.Cancellation_Date_Tract__c; 
                                    }else{
                                        if(dateCancelYear1 < instOfOpp.Cancellation_Date_Tract__c)
                                        dateCancelYear1 = instOfOpp.Cancellation_Date_Tract__c;
                                    }
                                }*/
                                //Adjusting the cancellation amount
                                
                                //Changes related to selected opps movement.
                                if(instOfOpp.Send_This_To_Tract__c == false){
                                    dateCancelYear1 = system.today();
                                }
                                //Changes related to selected opps movement.
                                
                                instOfpp.Year_1_Value__c = intContYear1Total;
                                //}
                                instOfpp.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                                instOfpp.Year_1_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                                instOfpp.Year_1_End_Date__c = instOfOpp.Opp_End_Date__c;
                                if(instOfOpp.OptOutDate__c != null){
                                    instOfpp.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                                }
                                if(instOfOpp.Liquidation_Fee__c != null){
                                    intLiqYear1Total = intLiqYear1Total + instOfOpp.Liquidation_Fee__c;
                                    instOfpp.Year_1_Liquidation_fee__c = intLiqYear1Total;  
                                }
                                
                                /*instOfppSec.Year_1_Contract_Type__c = instOfOpp.New_Type__c;
                                if(instOfOpp.Value__c != null){
                                    instOfppSec.Year_1_Value__c = instOfOpp.Value__c;
                                }
                                instOfppSec.Year_1_Agreement__c = instOfOpp.Deal_Year__c;
                                instOfppSec.Year_1_Start_Date__c = instOfOpp.ContractStartDate__c;
                                instOfppSec.Year_1_End_Date__c = instOfOpp.ContractEndDate__c;
                                if(instOfOpp.OptOutDate__c != null){
                                    instOfppSec.Year_1_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                                }
                                if(instOfOpp.Liquidation_Fee__c != null){
                                    instOfppSec.Year_1_Liquidation_fee__c = instOfOpp.Liquidation_Fee__c;   
                                }*/
                            }else if(instOfOpp.Deal_Year__c == '2'){
                                mapDealYearStr.put(instOfOpp.Deal_Year__c,instOfOpp.Deal_Year__c);
                                instOfpp.Year_2_Contract_Type__c = instOfOpp.New_Type__c;
                                //if(instOfOpp.Value__c != null){
                                
                                //Changes related to selected opps movement.
                                system.debug('instOfOpp.New_Type__c'+instOfOpp.New_Type__c);
                                instOfpp.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                                //instOfpp.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                                //instOfpp.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                                instOfpp.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                                instOfpp.Product__c = instOfOpp.Product__c;
                                instOfpp.OptOutDate__c = instOfOpp.OptOutDate__c;
                                //instOfpp.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                                instOfpp.Currency__c = instOfOpp.Currency__c;
                                instOfpp.Forex_rate__c = instOfOpp.Forex_rate__c;
                                instOfpp.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                                instOfpp.AccountId = instOfOpp.AccountId;
                                instOfpp.Opp_Type_Classification__c = 'Master Straightline';
                                instOfpp.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                                instOfpp.CloseDate = instOfOpp.CloseDate;
                                instOfpp.Product_Category_Tract__c = instOfOpp.Product_Category__c;
                                instOfpp.ContractReceived__c = instOfOpp.ContractReceived__c;
                                instOfpp.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                                oppNameStr = mapMonth.get(instOfOpp.CloseDate.month())+' ' + String.valueOf(instOfOpp.CloseDate.year());
                                //Changes related to selected opps movement.
                                
                                if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')
                                instOfpp.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;
                                
                                Double intTotal = 0;
                                if(instOfOpp.MaintenanceFee__c != null){
                                    intTotal = instOfOpp.MaintenanceFee__c;
                                }
                                if(instOfOpp.New_Amount__c != null){
                                    intTotal = intTotal + instOfOpp.New_Amount__c;
                                }
                                if(instOfOpp.Convinience_Fee__c != null){
                                    intTotal = intTotal + instOfOpp.Convinience_Fee__c;
                                }
                                if(mapOppIdFeat.containsKey(instOfOpp.Id)){
                                    intTotal = intTotal + mapOppIdFeat.get(instOfOpp.Id);
                                }
                                if(instOfOpp.Discount__c != null){
                                    intTotal = intTotal - instOfOpp.Discount__c;
                                }
                                if(instOfOpp.Price_Adjustment__c != null){
                                    intTotal = intTotal + instOfOpp.Price_Adjustment__c;
                                }
                                
                                intContYear2Total = intContYear2Total + intTotal;
                                
                                //Adjusting the cancellation amount
                                if(instOfOpp.Counted_sales_Cancellation_Value__c != null)
                                intContYear2Total = intContYear2Total - instOfOpp.Counted_sales_Cancellation_Value__c;
                                /*if(instOfOpp.Cancellation_Date_Tract__c != null){
                                    if(dateCancelYear2 == null){
                                        dateCancelYear2 = instOfOpp.Cancellation_Date_Tract__c; 
                                    }else{
                                        if(dateCancelYear2 < instOfOpp.Cancellation_Date_Tract__c)
                                        dateCancelYear2 = instOfOpp.Cancellation_Date_Tract__c;
                                    }
                                }*/
                                //Adjusting the cancellation amount
                                
                                //Changes related to selected opps movement.
                                if(instOfOpp.Send_This_To_Tract__c == false){
                                    dateCancelYear2 = system.today();
                                }
                                //Changes related to selected opps movement.
                                
                                instOfpp.Year_2_Value__c = intContYear2Total;
                                //}
                                instOfpp.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                                instOfpp.Year_2_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                                instOfpp.Year_2_End_Date__c = instOfOpp.Opp_End_Date__c;
                                if(instOfOpp.OptOutDate__c != null){
                                    instOfpp.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                                }
                                if(instOfOpp.OptOutDate__c != null){
                                    instOfpp.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;  
                                }
                                if(instOfOpp.Liquidation_Fee__c != null){
                                    intLiqYear2Total = intLiqYear2Total + instOfOpp.Liquidation_Fee__c;
                                    instOfpp.Year_2_Liquidation_fee__c = intLiqYear2Total;  
                                }
                                
                                /*
                                instOfppSec.Year_2_Contract_Type__c = instOfOpp.New_Type__c;
                                if(instOfOpp.Value__c != null){
                                    instOfppSec.Year_2_Value__c = instOfOpp.Value__c;   
                                }
                                instOfppSec.Year_2_Agreement__c = instOfOpp.Deal_Year__c;
                                instOfppSec.Year_2_Start_Date__c = instOfOpp.ContractStartDate__c;
                                instOfppSec.Year_2_End_Date__c = instOfOpp.ContractEndDate__c;
                                if(instOfOpp.OptOutDate__c != null){
                                    instOfppSec.Year_2_Opt_out_Date__c = instOfOpp.OptOutDate__c;   
                                }
                                if(instOfOpp.Liquidation_Fee__c != null){
                                    instOfppSec.Year_2_Liquidation_fee__c = instOfOpp.Liquidation_Fee__c;   
                                }*/
                            }else if(instOfOpp.Deal_Year__c == '3'){
                                mapDealYearStr.put(instOfOpp.Deal_Year__c,instOfOpp.Deal_Year__c);
                                instOfpp.Year_3_Contract_Type__c = instOfOpp.New_Type__c;
                                //if(instOfOpp.Value__c != null){
                                
                                //Changes related to selected opps movement.
                                system.debug('instOfOpp.New_Type__c'+instOfOpp.New_Type__c);
                                instOfpp.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                                //instOfpp.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                                //instOfpp.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                                instOfpp.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                                instOfpp.Product__c = instOfOpp.Product__c;
                                instOfpp.OptOutDate__c = instOfOpp.OptOutDate__c;
                                //instOfpp.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                                instOfpp.Currency__c = instOfOpp.Currency__c;
                                instOfpp.Forex_rate__c = instOfOpp.Forex_rate__c;
                                instOfpp.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                                instOfpp.AccountId = instOfOpp.AccountId;
                                instOfpp.Opp_Type_Classification__c = 'Master Straightline';
                                instOfpp.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                                instOfpp.CloseDate = instOfOpp.CloseDate;
                                instOfpp.Product_Category_Tract__c = instOfOpp.Product_Category__c;
                                instOfpp.ContractReceived__c = instOfOpp.ContractReceived__c;
                                instOfpp.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                                oppNameStr = mapMonth.get(instOfOpp.CloseDate.month())+' ' + String.valueOf(instOfOpp.CloseDate.year());
                                //Changes related to selected opps movement.
                                
                                if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')
                                instOfpp.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;
                                
                                Double intTotal = 0;
                                if(instOfOpp.MaintenanceFee__c != null){
                                    intTotal = instOfOpp.MaintenanceFee__c;
                                }
                                if(instOfOpp.New_Amount__c != null){
                                    intTotal = intTotal + instOfOpp.New_Amount__c;
                                }
                                if(instOfOpp.Convinience_Fee__c != null){
                                    intTotal = intTotal + instOfOpp.Convinience_Fee__c;
                                }
                                if(mapOppIdFeat.containsKey(instOfOpp.Id)){
                                    intTotal = intTotal + mapOppIdFeat.get(instOfOpp.Id);
                                }
                                if(instOfOpp.Discount__c != null){
                                    intTotal = intTotal - instOfOpp.Discount__c;
                                }
                                if(instOfOpp.Price_Adjustment__c != null){
                                    intTotal = intTotal + instOfOpp.Price_Adjustment__c;
                                }
                                
                                intContYear3Total = intContYear3Total + intTotal;
                                
                                //Adjusting the cancellation amount
                                if(instOfOpp.Counted_sales_Cancellation_Value__c != null)
                                intContYear3Total = intContYear3Total - instOfOpp.Counted_sales_Cancellation_Value__c;
                                /*if(instOfOpp.Cancellation_Date_Tract__c != null){
                                    if(dateCancelYear3 == null){
                                        dateCancelYear3 = instOfOpp.Cancellation_Date_Tract__c; 
                                    }else{
                                        if(dateCancelYear3 < instOfOpp.Cancellation_Date_Tract__c)
                                        dateCancelYear3 = instOfOpp.Cancellation_Date_Tract__c;
                                    }
                                }*/
                                //Adjusting the cancellation amount
                                
                                //Changes related to selected opps movement.
                                if(instOfOpp.Send_This_To_Tract__c == false){
                                    dateCancelYear3 = system.today();
                                }
                                //Changes related to selected opps movement.
                                
                                instOfpp.Year_3_Value__c = intContYear3Total;  
                                //}
                                instOfpp.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                                instOfpp.Year_3_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                                instOfpp.Year_3_End_Date__c = instOfOpp.Opp_End_Date__c;
                                if(instOfOpp.OptOutDate__c != null){
                                    instOfpp.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                                }
                                if(instOfOpp.Liquidation_Fee__c != null){
                                    intLiqYear3Total = intLiqYear3Total + instOfOpp.Liquidation_Fee__c;
                                    instOfpp.Year_3_Liquidation_fee__c = intLiqYear3Total;  
                                }
                                
                                /*instOfppSec.Year_3_Contract_Type__c = instOfOpp.New_Type__c;
                                if(instOfOpp.Value__c != null){
                                    instOfppSec.Year_3_Value__c = instOfOpp.Value__c;
                                }
                                instOfppSec.Year_3_Agreement__c = instOfOpp.Deal_Year__c;
                                instOfppSec.Year_3_Start_Date__c = instOfOpp.ContractStartDate__c;
                                instOfppSec.Year_3_End_Date__c = instOfOpp.ContractEndDate__c;
                                if(instOfOpp.OptOutDate__c != null){
                                    instOfppSec.Year_3_Opt_out_Date__c = instOfOpp.OptOutDate__c;
                                }
                                if(instOfOpp.Liquidation_Fee__c != null){
                                    instOfppSec.Year_3_Liquidation_fee__c = instOfOpp.Liquidation_Fee__c;   
                                }*/
                            }else if(instOfOpp.Deal_Year__c == '4'){
                                mapDealYearStr.put(instOfOpp.Deal_Year__c,instOfOpp.Deal_Year__c);
                                instOfpp.Year_4_Contract_Type__c = instOfOpp.New_Type__c;
                                //if(instOfOpp.Value__c != null){
                                
                                //Changes related to selected opps movement.
                                system.debug('instOfOpp.New_Type__c'+instOfOpp.New_Type__c);
                                instOfpp.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                                //instOfpp.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                                //instOfpp.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                                instOfpp.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                                instOfpp.Product__c = instOfOpp.Product__c;
                                instOfpp.OptOutDate__c = instOfOpp.OptOutDate__c;
                                //instOfpp.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                                instOfpp.Currency__c = instOfOpp.Currency__c;
                                instOfpp.Forex_rate__c = instOfOpp.Forex_rate__c;
                                instOfpp.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                                instOfpp.AccountId = instOfOpp.AccountId;
                                instOfpp.Opp_Type_Classification__c = 'Master Straightline';
                                instOfpp.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                                instOfpp.CloseDate = instOfOpp.CloseDate;
                                instOfpp.Product_Category_Tract__c = instOfOpp.Product_Category__c;
                                instOfpp.ContractReceived__c = instOfOpp.ContractReceived__c;
                                instOfpp.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                                oppNameStr = mapMonth.get(instOfOpp.CloseDate.month())+' ' + String.valueOf(instOfOpp.CloseDate.year());
                                //Changes related to selected opps movement.
                                
                                if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')
                                instOfpp.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;
                                
                                Double intTotal = 0;
                                if(instOfOpp.MaintenanceFee__c != null){
                                    intTotal = instOfOpp.MaintenanceFee__c;
                                }
                                if(instOfOpp.New_Amount__c != null){
                                    intTotal = intTotal + instOfOpp.New_Amount__c;
                                }
                                if(instOfOpp.Convinience_Fee__c != null){
                                    intTotal = intTotal + instOfOpp.Convinience_Fee__c;
                                }
                                if(mapOppIdFeat.containsKey(instOfOpp.Id)){
                                    intTotal = intTotal + mapOppIdFeat.get(instOfOpp.Id);
                                }
                                if(instOfOpp.Discount__c != null){
                                    intTotal = intTotal - instOfOpp.Discount__c;
                                }
                                if(instOfOpp.Price_Adjustment__c != null){
                                    intTotal = intTotal + instOfOpp.Price_Adjustment__c;
                                }
                                
                                intContYear4Total = intContYear4Total + intTotal;
                                
                                //Adjusting the cancellation amount
                                if(instOfOpp.Counted_sales_Cancellation_Value__c != null)
                                intContYear4Total = intContYear4Total - instOfOpp.Counted_sales_Cancellation_Value__c;
                                /*if(instOfOpp.Cancellation_Date_Tract__c != null){
                                    if(dateCancelYear4 == null){
                                        dateCancelYear4 = instOfOpp.Cancellation_Date_Tract__c; 
                                    }else{
                                        if(dateCancelYear4 < instOfOpp.Cancellation_Date_Tract__c)
                                        dateCancelYear4 = instOfOpp.Cancellation_Date_Tract__c;
                                    }
                                }*/
                                //Adjusting the cancellation amount
                                
                                //Changes related to selected opps movement.
                                if(instOfOpp.Send_This_To_Tract__c == false){
                                    dateCancelYear4 = system.today();
                                }
                                //Changes related to selected opps movement.
                                
                                instOfpp.Year_4_Value__c = intContYear4Total;
                                //}
                                instOfpp.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                                instOfpp.Year_4_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                                instOfpp.Year_4_End_Date__c = instOfOpp.Opp_End_Date__c;
                                if(instOfOpp.OptOutDate__c != null){
                                    instOfpp.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c;  
                                }
                                if(instOfOpp.Liquidation_Fee__c != null){
                                    intLiqYear4Total = intLiqYear4Total + instOfOpp.Liquidation_Fee__c;
                                    instOfpp.Year_4_Liquidation_fee__c = intLiqYear4Total;  
                                }
                                
                                /*instOfppSec.Year_4_Contract_Type__c = instOfOpp.New_Type__c;
                                if(instOfOpp.Value__c != null){
                                    instOfppSec.Year_4_Value__c = instOfOpp.Value__c;   
                                }
                                instOfppSec.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                                instOfppSec.Year_4_Start_Date__c = instOfOpp.ContractStartDate__c;
                                instOfppSec.Year_4_End_Date__c = instOfOpp.ContractEndDate__c;
                                if(instOfOpp.OptOutDate__c != null){
                                    instOfppSec.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c;   
                                }
                                if(instOfOpp.Liquidation_Fee__c != null){
                                    instOfppSec.Year_4_Liquidation_fee__c = instOfOpp.Liquidation_Fee__c;   
                                }*/
                            }else if(instOfOpp.Deal_Year__c == '5'){
                                mapDealYearStr.put(instOfOpp.Deal_Year__c,instOfOpp.Deal_Year__c);
                                instOfpp.Year_5_Contract_Type__c = instOfOpp.New_Type__c;
                                //if(instOfOpp.Value__c != null){
                                
                                //Changes related to selected opps movement.
                                system.debug('instOfOpp.New_Type__c'+instOfOpp.New_Type__c);
                                instOfpp.Contract_Type_Tract__c = instOfOpp.New_Type__c;
                                //instOfpp.ContractStartDate__c = instOfOpp.ContractStartDate__c;
                                //instOfpp.ContractEndDate__c = instOfOpp.ContractEndDate__c;
                                instOfpp.Contract_Number_New__c = instOfOpp.Contract_Number_New__c;
                                instOfpp.Product__c = instOfOpp.Product__c;
                                instOfpp.OptOutDate__c = instOfOpp.OptOutDate__c;
                                //instOfpp.Year_1_at_Risk__c = instOfOpp.Year_1_at_Risk__c;
                                instOfpp.Currency__c = instOfOpp.Currency__c;
                                instOfpp.Forex_rate__c = instOfOpp.Forex_rate__c;
                                instOfpp.Deal_Booked_In__c = instOfOpp.Deal_Booked_In__c;
                                instOfpp.AccountId = instOfOpp.AccountId;
                                instOfpp.Opp_Type_Classification__c = 'Master Straightline';
                                instOfpp.Price_per_lead__c = instOfOpp.Price_per_lead__c;
                                instOfpp.CloseDate = instOfOpp.CloseDate;
                                instOfpp.Product_Category_Tract__c = instOfOpp.Product_Category__c;
                                instOfpp.ContractReceived__c = instOfOpp.ContractReceived__c;
                                instOfpp.CurrencyIsoCode = instOfOpp.CurrencyIsoCode;
                                oppNameStr = mapMonth.get(instOfOpp.CloseDate.month())+' ' + String.valueOf(instOfOpp.CloseDate.year());
                                //Changes related to selected opps movement.
                                
                                if(instOfOpp.Clubbed_Opportunity__c == true && instOfOpp.Clubbed_Tract_Billing_Account__c!=null && instOfOpp.Clubbed_Tract_Billing_Account__c!='')
                                instOfpp.Tract_Account_Number__c = instOfOpp.Clubbed_Tract_Billing_Account__c;
                                
                                Double intTotal = 0;
                                if(instOfOpp.MaintenanceFee__c != null){
                                    intTotal = instOfOpp.MaintenanceFee__c;
                                }
                                if(instOfOpp.New_Amount__c != null){
                                    intTotal = intTotal + instOfOpp.New_Amount__c;
                                }
                                if(instOfOpp.Convinience_Fee__c != null){
                                    intTotal = intTotal + instOfOpp.Convinience_Fee__c;
                                }
                                if(mapOppIdFeat.containsKey(instOfOpp.Id)){
                                    intTotal = intTotal + mapOppIdFeat.get(instOfOpp.Id);
                                }
                                if(instOfOpp.Discount__c != null){
                                    intTotal = intTotal - instOfOpp.Discount__c;
                                }
                                if(instOfOpp.Price_Adjustment__c != null){
                                    intTotal = intTotal + instOfOpp.Price_Adjustment__c;
                                }
                                
                                intContYear5Total = intContYear5Total + intTotal;
                                
                                //Adjusting the cancellation amount
                                if(instOfOpp.Counted_sales_Cancellation_Value__c != null)
                                intContYear5Total = intContYear5Total - instOfOpp.Counted_sales_Cancellation_Value__c;
                                /*if(instOfOpp.Cancellation_Date_Tract__c != null){
                                    if(dateCancelYear5 == null){
                                        dateCancelYear5 = instOfOpp.Cancellation_Date_Tract__c; 
                                    }else{
                                        if(dateCancelYear5 < instOfOpp.Cancellation_Date_Tract__c)
                                        dateCancelYear5 = instOfOpp.Cancellation_Date_Tract__c;
                                    }
                                }*/
                                //Adjusting the cancellation amount
                                
                                //Changes related to selected opps movement.
                                if(instOfOpp.Send_This_To_Tract__c == false){
                                    dateCancelYear5 = system.today();
                                }
                                //Changes related to selected opps movement.
                                
                                instOfpp.Year_5_Value__c = intContYear5Total;
                                //}
                                instOfpp.Year_5_Agreement__c = instOfOpp.Deal_Year__c;
                                instOfpp.Year_5_Start_Date__c = instOfOpp.Opportunity_Start_Date__c;
                                instOfpp.Year_5_End_Date__c = instOfOpp.Opp_End_Date__c;
                                if(instOfOpp.OptOutDate__c != null){
                                    instOfpp.Year_5_Opt_out_Date__c = instOfOpp.OptOutDate__c;  
                                }
                                if(instOfOpp.Liquidation_Fee__c != null){
                                    intLiqYear5Total = intLiqYear5Total + instOfOpp.Liquidation_Fee__c;
                                    instOfpp.Year_5_Liquidation_fee__c = intLiqYear5Total;  
                                }
                                
                                /*instOfppSec.Year_4_Contract_Type__c = instOfOpp.New_Type__c;
                                if(instOfOpp.Value__c != null){
                                    instOfppSec.Year_4_Value__c = instOfOpp.Value__c;   
                                }
                                instOfppSec.Year_4_Agreement__c = instOfOpp.Deal_Year__c;
                                instOfppSec.Year_4_Start_Date__c = instOfOpp.ContractStartDate__c;
                                instOfppSec.Year_4_End_Date__c = instOfOpp.ContractEndDate__c;
                                if(instOfOpp.OptOutDate__c != null){
                                    instOfppSec.Year_4_Opt_out_Date__c = instOfOpp.OptOutDate__c;   
                                }
                                if(instOfOpp.Liquidation_Fee__c != null){
                                    instOfppSec.Year_4_Liquidation_fee__c = instOfOpp.Liquidation_Fee__c;   
                                }*/
                            }
                        }
                    }
                    
                    if(!mapDealYearStr.containsKey('1')){
                        instOfpp.Year_1_Contract_Type__c = '';
                        instOfpp.Year_1_Value__c = null;
                        instOfpp.Year_1_Agreement__c = null;
                        instOfpp.Year_1_Start_Date__c = null;
                        instOfpp.Year_1_End_Date__c = null;
                        instOfOpp.Year_1_Opt_out_Date__c = null;
                        instOfOpp.Year_1_Liquidation_fee__c = null;
                        instOfOpp.Contract_Total_Year_1_Rev_Rec_Rule_Assgn__c = null;
                    }
                    if(!mapDealYearStr.containsKey('2')){
                        instOfpp.Year_2_Contract_Type__c = '';
                        instOfpp.Year_2_Value__c = null;
                        instOfpp.Year_2_Agreement__c = null;
                        instOfpp.Year_2_Start_Date__c = null;
                        instOfpp.Year_2_End_Date__c = null;
                        instOfOpp.Year_2_Opt_out_Date__c = null;
                        instOfOpp.Year_2_Liquidation_fee__c = null;
                        instOfOpp.Contract_Total_Year_2_Rev_Rec_Rule_Assgn__c = null;
                    }
                    if(!mapDealYearStr.containsKey('3')){
                        instOfpp.Year_3_Contract_Type__c = '';
                        instOfpp.Year_3_Value__c = null;
                        instOfpp.Year_3_Agreement__c = null;
                        instOfpp.Year_3_Start_Date__c = null;
                        instOfpp.Year_3_End_Date__c = null;
                        instOfOpp.Year_3_Opt_out_Date__c = null;
                        instOfOpp.Year_3_Liquidation_fee__c = null;
                        instOfOpp.Contract_Total_Year_3_Rev_Rec_Rule_Assgn__c = null;
                    }
                    if(!mapDealYearStr.containsKey('4')){
                        instOfpp.Year_4_Contract_Type__c = '';
                        instOfpp.Year_4_Value__c = null;
                        instOfpp.Year_4_Agreement__c = null;
                        instOfpp.Year_4_Start_Date__c = null;
                        instOfpp.Year_4_End_Date__c = null;
                        instOfOpp.Year_4_Opt_out_Date__c = null;
                        instOfOpp.Year_4_Liquidation_fee__c = null;
                        instOfOpp.Contract_Total_Year_4_Rev_Rec_Rule_Assgn__c = null;
                    }
                    if(!mapDealYearStr.containsKey('5')){
                        instOfpp.Year_5_Contract_Type__c = '';
                        instOfpp.Year_5_Value__c = null;
                        instOfpp.Year_5_Agreement__c = null;
                        instOfpp.Year_5_Start_Date__c = null;
                        instOfpp.Year_5_End_Date__c = null;
                        instOfOpp.Year_5_Opt_out_Date__c = null;
                        instOfOpp.Year_5_Liquidation_fee__c = null;
                        instOfOpp.Contract_Total_Year_5_Rev_Rec_Rule_Assgn__c = null;
                    }
                    
                    Decimal temp;
                    try{ 
                        temp = 0 + mapIdDeciStraight.get(strContNum);
                        system.debug('temp++'+temp);
                    } catch (exception e){
                        temp = 0;
                    }
                    Decimal tempSec;
                    try{ 
                        tempSec = 0 + mapIdDeciMil.get(strContNum);
                    } catch (exception e){
                        tempSec = 0;
                    }
                    //Adjusting the cancellation amount && Tract implementation Date change
                    List<Date> lstDateCancel = new List<Date>();
                    
                    if(dateCancelYear5 != null)
                    lstDateCancel.add(dateCancelYear5);
                    
                    if(dateCancelYear4 != null)
                    lstDateCancel.add(dateCancelYear4);
                        
                    if(dateCancelYear3 != null)
                    lstDateCancel.add(dateCancelYear3);
                    
                    if(dateCancelYear2 != null)
                    lstDateCancel.add(dateCancelYear2);
                    
                    if(dateCancelYear1 != null)
                    lstDateCancel.add(dateCancelYear1);
                    
                    if(lstDateCancel.size()>0){
                        lstDateCancel.sort();
                        Integer intSizeLst = lstDateCancel.size();
                        instOfpp.Tract_Implementation_Date__c = lstDateCancel[intSizeLst-1];    
                    }
                    //Adjusting the cancellation amount && Tract implementation Date change
                    /*
                    if(dateCancelYear5 > dateCancelYear4 && dateCancelYear5 > dateCancelYear3 && dateCancelYear5 > dateCancelYear2 && dateCancelYear5 > dateCancelYear1)
                    instOfpp.Tract_Implementation_Date__c = dateCancelYear5;
                    if(dateCancelYear4 > dateCancelYear5 && dateCancelYear4 > dateCancelYear3 && dateCancelYear4 > dateCancelYear2 && dateCancelYear4 > dateCancelYear1)
                    instOfpp.Tract_Implementation_Date__c = dateCancelYear4;
                    if(dateCancelYear3 > dateCancelYear5 && dateCancelYear3 > dateCancelYear4 && dateCancelYear3 > dateCancelYear2 && dateCancelYear3 > dateCancelYear1)
                    instOfpp.Tract_Implementation_Date__c = dateCancelYear3;
                    if(dateCancelYear2 > dateCancelYear5 && dateCancelYear2 > dateCancelYear3 && dateCancelYear2 > dateCancelYear4 && dateCancelYear2 > dateCancelYear1)
                    instOfpp.Tract_Implementation_Date__c = dateCancelYear2;
                    if(dateCancelYear1 > dateCancelYear4 && dateCancelYear1 > dateCancelYear3 && dateCancelYear1 > dateCancelYear2 && dateCancelYear1 > dateCancelYear5)
                    instOfpp.Tract_Implementation_Date__c = dateCancelYear1;
                    */
                    List<Date> lstDateStart = new List<Date>();
                    List<Date> lstDateEnd = new List<Date>();
                    
                    if(instOfpp.Year_1_Start_Date__c != null)
                    lstDateStart.add(instOfpp.Year_1_Start_Date__c);
                    if(instOfpp.Year_2_Start_Date__c != null)
                    lstDateStart.add(instOfpp.Year_2_Start_Date__c);
                    if(instOfpp.Year_3_Start_Date__c != null)
                    lstDateStart.add(instOfpp.Year_3_Start_Date__c);
                    if(instOfpp.Year_4_Start_Date__c != null)
                    lstDateStart.add(instOfpp.Year_4_Start_Date__c);
                    if(instOfpp.Year_5_Start_Date__c != null)
                    lstDateStart.add(instOfpp.Year_5_Start_Date__c);
                    
                    if(instOfpp.Year_5_End_Date__c != null)
                    lstDateEnd.add(instOfpp.Year_5_End_Date__c);
                    if(instOfpp.Year_4_End_Date__c != null)
                    lstDateEnd.add(instOfpp.Year_4_End_Date__c);
                    if(instOfpp.Year_3_End_Date__c != null)
                    lstDateEnd.add(instOfpp.Year_3_End_Date__c);
                    if(instOfpp.Year_2_End_Date__c != null)
                    lstDateEnd.add(instOfpp.Year_2_End_Date__c);
                    if(instOfpp.Year_1_End_Date__c != null)
                    lstDateEnd.add(instOfpp.Year_1_End_Date__c);
                    
                    if(lstDateStart.size()>0){
                        lstDateStart.sort();
                        instOfpp.Year_1_Start_Date__c = lstDateStart[0];
                        instOfpp.ContractStartDate__c = lstDateStart[0];    
                    }
                    
                    if(lstDateEnd.size()>0){
                        lstDateEnd.sort();
                        Integer intSizeOfList =  lstDateEnd.size(); 
                        instOfpp.ContractEndDate__c = lstDateEnd[intSizeOfList - 1];
                    }
                    
                    Decimal contTotal =  maintenanceFee + usagePackageFee + temp;
                    instOfpp.Name = instOfpp.Product__c + ' ' + oppNameStr + ' ' + instOfpp.Contract_Type_Tract__c + ' ' + 'Straightline';
                    instOfpp.MaintenanceFee__c = maintenanceFee;
                    instOfpp.New_Amount__c = usagePackageFee;
                    instOfpp.Discount__c = Discount;
                    instOfpp.Convinience_Fee__c = convenienceFee;
                    instOfpp.of_Leads_Purchased__c = numOfleadP;
                    instOfpp.Events__c = numOfEvents;
                    instOfpp.Straight_Total__c = maintenanceFee + usagePackageFee + temp + convenienceFee;
                    instOfpp.Contract_Total_Tract__c = (maintenanceFee + usagePackageFee + temp + convenienceFee+ intPrceAdj) - (Discount  + CancellationAmt);
                    instOfpp.Milestone_Total__c = tempSec;
                    instOfpp.Contract_Total_Tract_Review__c = cntTotalReview;
                    /*
                    contTotal =  temp;
                    instOfppSec.Name = instOfppSec.Product__c +' ' + oppNameStr +' ' + instOfpp.Contract_Type_Tract__c +' ' + 'Milestone';
                    instOfppSec.MaintenanceFee__c = maintenanceFee;
                    instOfppSec.New_Amount__c = usagePackageFee;
                    instOfppSec.Discount__c = Discount;
                    instOfppSec.Convinience_Fee__c = convenienceFee;
                    instOfppSec.of_Leads_Purchased__c = numOfleadP;
                    instOfppSec.Events__c = numOfEvents;
                    instOfppSec.Straight_Total__c = maintenanceFee + usagePackageFee + temp;
                    instOfppSec.Contract_Total_Tract__c = temp;
                    instOfppSec.Milestone_Total__c = tempSec;*/
                }
                lstOppTractUpd.add(instOfpp);
                //lstOppTractUpd.add(instOfppSec);
            }
        }
    }
    public List<Opportunity> getCSNList(List<Opportunity> lstOppTractInsCSN,map<String,Decimal> mapPriceAdjYear5,map<String,Decimal> mapPriceAdjYear4,map<String,Decimal> mapPriceAdjYear3,map<String,Decimal> mapPriceAdjYear2,map<String,Decimal> mapPriceAdjYear1){
        Integer counterSec = 0;
        map<String,List<Opportunity>> mapCSNOppsFinalUpdate = new map<String,List<Opportunity>>();
        system.debug('lstOppTractInsCSN++'+lstOppTractInsCSN);
        for(Opportunity instOfOpp : lstOppTractInsCSN){
            if(instOfOpp.Product__c =='CSN'){
                if(mapCSNOppsFinalUpdate.ContainsKey(instOfOpp.Contract_Number_New__c)){
                    List<Opportunity> lstOpp = mapCSNOppsFinalUpdate.get(instOfOpp.Contract_Number_New__c);
                    lstOpp.add(instOfOpp);
                    mapCSNOppsFinalUpdate.put(instOfOpp.Contract_Number_New__c,lstOpp);
                }else{
                    List<Opportunity> lstOpp = new List<Opportunity>();
                    lstOpp.add(instOfOpp);
                    system.debug('lstOpp++'+lstOpp);
                    mapCSNOppsFinalUpdate.put(instOfOpp.Contract_Number_New__c,lstOpp);
                }   
            }
        }
        system.debug('mapCSNOppsFinalUpdate++'+mapCSNOppsFinalUpdate);
        system.debug('mapCSNOppsFinalUpdate++'+mapCSNOppsFinalUpdate);
        
        List<Opportunity> lstOppCSNUpdate = new List<Opportunity>();
        
        
        for(String contractNumberStr : mapCSNOppsFinalUpdate.KeySet()){
            system.debug('mapCSNOppsFinalUpdate.get(contractNumberStr).size()++'+mapCSNOppsFinalUpdate.get(contractNumberStr).size());
            if(mapCSNOppsFinalUpdate.get(contractNumberStr).size() == 1){
                List<Opportunity> instOfOpp = mapCSNOppsFinalUpdate.get(contractNumberStr);
                
                if(instOfOpp[0].Year_1_Value__c ==null)
                instOfOpp[0].Year_1_Value__c= 0;
                if(instOfOpp[0].Year_2_Value__c ==null)
                instOfOpp[0].Year_2_Value__c= 0;
                if(instOfOpp[0].Year_3_Value__c ==null)
                instOfOpp[0].Year_3_Value__c= 0;
                if(instOfOpp[0].Year_4_Value__c ==null)
                instOfOpp[0].Year_4_Value__c= 0;
                if(instOfOpp[0].Year_5_Value__c ==null)
                instOfOpp[0].Year_5_Value__c= 0;
                
                if(mapPriceAdjYear5.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_5_Value__c = instOfOpp[0].Year_5_Value__c + mapPriceAdjYear5.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapPriceAdjYear4.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_4_Value__c = instOfOpp[0].Year_4_Value__c + mapPriceAdjYear4.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapPriceAdjYear3.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_3_Value__c = instOfOpp[0].Year_3_Value__c + mapPriceAdjYear3.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapPriceAdjYear2.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    system.debug('instOfOpp[0].Year_2_Value__c++'+instOfOpp[0].Year_2_Value__c);
                    system.debug('mapPriceAdjYear2.get(instOfOpp[0].Contract_Number_New__c++'+mapPriceAdjYear2.get(instOfOpp[0].Contract_Number_New__c));
                    instOfOpp[0].Year_2_Value__c = instOfOpp[0].Year_2_Value__c + mapPriceAdjYear2.get(instOfOpp[0].Contract_Number_New__c);
                    system.debug('instOfOpp[0].Year_2_Value__c++'+instOfOpp[0].Year_2_Value__c);
                }
                if(mapPriceAdjYear1.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_1_Value__c = instOfOpp[0].Year_1_Value__c + mapPriceAdjYear1.get(instOfOpp[0].Contract_Number_New__c);
                }
                
                instOfOpp[0].Contract_Total_Tract__c = instOfOpp[0].Year_1_Value__c + instOfOpp[0].Year_2_Value__c + instOfOpp[0].Year_3_Value__c + instOfOpp[0].Year_4_Value__c + instOfOpp[0].Year_5_Value__c;
                lstOppCSNUpdate.add(instOfOpp[0]);
            }else{
                lstOppCSNUpdate.addAll(mapCSNOppsFinalUpdate.get(contractNumberStr));
            }
        }
        return lstOppCSNUpdate;
    }
    
    public List<Opportunity> getCSNListSec(List<Opportunity> lstOppTractUpdCSN,map<String,Decimal> mapPriceAdjYear5,map<String,Decimal> mapPriceAdjYear4,map<String,Decimal> mapPriceAdjYear3,map<String,Decimal> mapPriceAdjYear2,map<String,Decimal> mapPriceAdjYear1,map<String,Decimal> mapCancellYear5,map<String,Decimal> mapCancellYear4,map<String,Decimal> mapCancellYear3,map<String,Decimal> mapCancellYear2,map<String,Decimal> mapCancellYear1){
        map<String,List<Opportunity>> mapCSNOppsFinalUpdateCan = new map<String,List<Opportunity>>();
        for(Opportunity instOfOpp : lstOppTractUpdCSN){
            if(instOfOpp.Product__c =='CSN'){
                if(mapCSNOppsFinalUpdateCan.ContainsKey(instOfOpp.Contract_Number_New__c)){
                    List<Opportunity> lstOpp = mapCSNOppsFinalUpdateCan.get(instOfOpp.Contract_Number_New__c);
                    lstOpp.add(instOfOpp);
                    mapCSNOppsFinalUpdateCan.put(instOfOpp.Contract_Number_New__c,lstOpp);
                }else{
                    List<Opportunity> lstOpp = new List<Opportunity>();
                    lstOpp.add(instOfOpp);
                    mapCSNOppsFinalUpdateCan.put(instOfOpp.Contract_Number_New__c,lstOpp);
                }   
            }
        }
        
        List<Opportunity> lstOppCSNUpdateSec = new List<Opportunity>();
        
        for(String contractNumberStr : mapCSNOppsFinalUpdateCan.KeySet()){
            if(mapCSNOppsFinalUpdateCan.get(contractNumberStr).size() == 1){
                List<Opportunity> instOfOpp = mapCSNOppsFinalUpdateCan.get(contractNumberStr);
                
                if(instOfOpp[0].Year_1_Value__c == null)
                instOfOpp[0].Year_1_Value__c = 0;
                if(instOfOpp[0].Year_2_Value__c == null)
                instOfOpp[0].Year_2_Value__c = 0;
                if(instOfOpp[0].Year_3_Value__c == null)
                instOfOpp[0].Year_3_Value__c = 0;
                if(instOfOpp[0].Year_4_Value__c == null)
                instOfOpp[0].Year_4_Value__c = 0;
                if(instOfOpp[0].Year_5_Value__c == null)
                instOfOpp[0].Year_5_Value__c = 0;
                
                if(mapCancellYear5.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_5_Value__c = instOfOpp[0].Year_5_Value__c - mapCancellYear5.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapCancellYear4.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_4_Value__c = instOfOpp[0].Year_4_Value__c - mapCancellYear4.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapCancellYear3.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_3_Value__c = instOfOpp[0].Year_3_Value__c - mapCancellYear3.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapCancellYear2.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_2_Value__c = instOfOpp[0].Year_2_Value__c - mapCancellYear2.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapCancellYear1.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_1_Value__c = instOfOpp[0].Year_1_Value__c - mapCancellYear1.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapPriceAdjYear5.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_5_Value__c = instOfOpp[0].Year_5_Value__c + mapPriceAdjYear5.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapPriceAdjYear4.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_4_Value__c = instOfOpp[0].Year_4_Value__c + mapPriceAdjYear4.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapPriceAdjYear3.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_3_Value__c = instOfOpp[0].Year_3_Value__c + mapPriceAdjYear3.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapPriceAdjYear2.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_2_Value__c = instOfOpp[0].Year_2_Value__c + mapPriceAdjYear2.get(instOfOpp[0].Contract_Number_New__c);
                }
                if(mapPriceAdjYear1.ContainsKey(instOfOpp[0].Contract_Number_New__c)){
                    instOfOpp[0].Year_1_Value__c = instOfOpp[0].Year_1_Value__c + mapPriceAdjYear1.get(instOfOpp[0].Contract_Number_New__c);
                }
                
                instOfOpp[0].Contract_Total_Tract__c = instOfOpp[0].Year_1_Value__c + instOfOpp[0].Year_2_Value__c + instOfOpp[0].Year_3_Value__c + instOfOpp[0].Year_4_Value__c + instOfOpp[0].Year_5_Value__c;
                lstOppCSNUpdateSec.add(instOfOpp[0]);
            }else{
                lstOppCSNUpdateSec.addAll(mapCSNOppsFinalUpdateCan.get(contractNumberStr));
            }
        }   
        return lstOppCSNUpdateSec;
    }
    
    //Updating according to the field value Set_Cancellation_Status__c
    // Returns a dynamic SOQL statement for the whole object, includes only creatable fields since we will be inserting a cloned result of this query
    public string getCreatableFieldsSOQL(String objectName){
         
        String selects = '';
        // Get a map of field name and field token
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        list<string> selectFields = new list<string>();
         
        if (fMap != null){
            for (Schema.SObjectField ft : fMap.values()){ // loop through all field tokens (ft)
                Schema.DescribeFieldResult fd = ft.getDescribe(); // describe each field (fd)
                if (fd.isCreateable()){ // field is creatable
                    selectFields.add(fd.getName());
                }
            }
        }
         
        if (!selectFields.isEmpty()){
            for (string s:selectFields){
                selects += s + ',';
            }
            if (selects.endsWith(',')){selects = selects.substring(0,selects.lastIndexOf(','));}
             
        }
         
        return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE Id=: ';
         
    }
    // Returns a dynamic SOQL statement for the whole object, includes only creatable fields since we will be inserting a cloned result of this query
    //Updating according to the field value Set_Cancellation_Status__c
    public void getTotals(List<Opportunity> lstOppTract){
        Decimal counterFTR=0;
        Decimal counterDGB=0;
        Decimal counterCSN=0;
        Decimal counterDPSLM=0;
        
        Integer counterFTRCheck = 0;
        Integer counterDGBCheck = 0;
        Integer counterCSNCheck = 0;
        Integer counterDPSLMCheck = 0;
        for(Opportunity instOfOpp : lstOppTract){
            //For CSN
            if(instOfOpp.Product__c == 'CSN'){
                if(mapCSNContrTotalRev.containsKey(instOfOpp.Contract_Number_New__c)){
                    Decimal deciContrTotal = mapCSNContrTotalRev.get(instOfOpp.Contract_Number_New__c);
                    deciContrTotal = deciContrTotal + instOfOpp.New_Contract_Total__c ; 
                    mapCSNContrTotalRev.put(instOfOpp.Contract_Number_New__c,deciContrTotal);
                }else{
                    if(instOfOpp.New_Contract_Total__c != null)
                    mapCSNContrTotalRev.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Contract_Total__c);
                }
                counterFTR = 0;
                counterDGB = 0;
                counterFTRCheck = 0;
                counterDGBCheck = 0;
                counterCSNCheck = 0;
                counterDPSLMCheck = 0;
                counterCSN = 0;
                counterDPSLM = 0;
                for(Feature_Set__c instOfFeat :  instOfOpp.Feature_Sets__r){
                    // Feature value null on Feature sets
                    if(instOfFeat.Feature__c != null && instOfFeat.Feature__c != ''){
                    // Feature value null on Feature sets    
                      if(mapFeatureTypeFTR.containsKey(instOfFeat.Feature__c.trim())){
                          counterFTR = counterFTR + instOfFeat.Total_Fees__c; 
                          counterFTRCheck++;
                      }
                      
                      if(mapFeatureTypeDGB.containsKey(instOfFeat.Feature__c.trim())){
                          counterDGB = counterDGB + instOfFeat.Total_Fees__c;
                          counterDGBCheck++;
                      }
                      //New TCV creation concept for CSN and DPS types
                      if(mapLicenceTypeCSNFeature.containsKey(instOfFeat.Feature__c.trim()) && mapLicenceType.ContainsKey(instOfOpp.License_Type__c)){
                          counterCSN = counterCSN + instOfFeat.Total_Fees__c;
                          counterCSNCheck++;
                      }
                      
                      if(mapLicenceTypeDpsSlmFeature.containsKey(instOfFeat.Feature__c.trim()) && mapLicenceTypeDPSSLM.ContainsKey(instOfOpp.License_Type__c)){
                          counterDPSLM = counterDPSLM + instOfFeat.Total_Fees__c;
                          counterDPSLMCheck++;
                      }
                    }    
                    //New TCV creation concept for CSN and DPS types
                }
                
                if(counterFTRCheck > 0){
                    mapOppIdTotalFeeFTR.put(instOfOpp.Id,counterFTR);
                    if(mapIdDeciStraightFTR.containskey(instOfOpp.Contract_Number_New__c)){
                        Decimal instOfDeci = mapIdDeciStraightFTR.get(instOfOpp.Contract_Number_New__c);
                        instOfDeci = instOfDeci + counterFTR;
                        mapIdDeciStraightFTR.put(instOfOpp.Contract_Number_New__c,instOfDeci);
                    }else{
                        mapIdDeciStraightFTR.put(instOfOpp.Contract_Number_New__c,counterFTR);
                        mapStraightCheck.put(instOfOpp.Contract_Number_New__c,instOfOpp.Contract_Number_New__c);
                    }
                }else{
                    //mapOppIdTotalFeeFTR.put(instOfOpp.Id,0);
                }
                
                if(counterDGBCheck > 0){
                    mapOppIdTotalFeeDGB.put(instOfOpp.Id,counterDGB);
                    if(mapIdDeciStraightDGB.containskey(instOfOpp.Contract_Number_New__c)){
                        Decimal instOfDeci = mapIdDeciStraightDGB.get(instOfOpp.Contract_Number_New__c);
                        instOfDeci = instOfDeci + counterDGB;
                        mapIdDeciStraightDGB.put(instOfOpp.Contract_Number_New__c,instOfDeci);
                    }else{
                        mapIdDeciStraightDGB.put(instOfOpp.Contract_Number_New__c,counterDGB);
                        mapStraightCheck.put(instOfOpp.Contract_Number_New__c,instOfOpp.Contract_Number_New__c);
                    }
                }else{
                    //mapOppIdTotalFeeDGB.put(instOfOpp.Id,0);
                }
                
                if(mapLicenceType.ContainsKey(instOfOpp.License_Type__c)){
                    mapOppIdTotalFeeCSN.put(instOfOpp.Id,instOfOpp.New_Amount__c);
                    if(mapIdDeciStraightCSN.containskey(instOfOpp.Contract_Number_New__c)){
                        Decimal instOfDeci = mapIdDeciStraightCSN.get(instOfOpp.Contract_Number_New__c);
                        if(instOfOpp.New_Amount__c != null)
                        instOfDeci = instOfDeci + instOfOpp.New_Amount__c;
                        mapIdDeciStraightCSN.put(instOfOpp.Contract_Number_New__c,instOfDeci);
                    }else{
                        mapIdDeciStraightCSN.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        mapStraightCheck.put(instOfOpp.Contract_Number_New__c,instOfOpp.Contract_Number_New__c);
                    }
                }
                
                if(mapLicenceTypeDPSSLM.ContainsKey(instOfOpp.License_Type__c)){
                    mapOppIdTotalFeeDPSSLM.put(instOfOpp.Id,instOfOpp.New_Amount__c);
                    if(mapIdDeciStraightDPSSLM.containskey(instOfOpp.Contract_Number_New__c)){
                        Decimal instOfDeci = mapIdDeciStraightDPSSLM.get(instOfOpp.Contract_Number_New__c);
                        if(instOfOpp.New_Amount__c != null)
                        instOfDeci = instOfDeci + instOfOpp.New_Amount__c;
                        mapIdDeciStraightDPSSLM.put(instOfOpp.Contract_Number_New__c,instOfDeci);
                    }else{
                        mapIdDeciStraightDPSSLM.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        mapStraightCheck.put(instOfOpp.Contract_Number_New__c,instOfOpp.Contract_Number_New__c);
                    }
                }
                
                //New TCV creation concept for CSN and DPS types
                if(counterCSNCheck > 0){
                    if(mapIdDeciStraightCSN.containskey(instOfOpp.Contract_Number_New__c)){
                        Decimal instOfDeci = mapIdDeciStraightCSN.get(instOfOpp.Contract_Number_New__c);
                        instOfDeci = instOfDeci + counterCSN;
                        mapIdDeciStraightCSN.put(instOfOpp.Contract_Number_New__c,instOfDeci);
                    }
                }
                
                if(counterDPSLMCheck > 0){
                    if(mapIdDeciStraightDPSSLM.containskey(instOfOpp.Contract_Number_New__c)){
                        Decimal instOfDeci = mapIdDeciStraightDPSSLM.get(instOfOpp.Contract_Number_New__c);
                        instOfDeci = instOfDeci + counterDPSLM;
                        mapIdDeciStraightDPSSLM.put(instOfOpp.Contract_Number_New__c,instOfDeci);
                    }
                }
                //New TCV creation concept for CSN and DPS types
                
                //To get Yearly Totals for CSN ,DGB,DPSSLM,FTR
                if(instOfOpp.Deal_Year__c == '1'){
                    //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
                    if(instOfOpp.Price_Adjustment__c!= null){
                        if(mapPriceAdjYear1.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal instDeci = mapPriceAdjYear1.get(instOfOpp.Contract_Number_New__c);
                            instDeci = instDeci + instOfOpp.Price_Adjustment__c;
                            mapPriceAdjYear1.put(instOfOpp.Contract_Number_New__c,instDeci);
                        }else{
                            mapPriceAdjYear1.put(instOfOpp.Contract_Number_New__c,instOfOpp.Price_Adjustment__c);
                        }   
                    }
                    
                    if(instOfOpp.Counted_sales_Cancellation_Value__c != null){
                        if(mapCancellYear1.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal instDeci = mapCancellYear1.get(instOfOpp.Contract_Number_New__c);
                            instDeci = instDeci + instOfOpp.Counted_sales_Cancellation_Value__c;
                            mapCancellYear1.put(instOfOpp.Contract_Number_New__c,instDeci);
                        }else{
                            mapCancellYear1.put(instOfOpp.Contract_Number_New__c,instOfOpp.Counted_sales_Cancellation_Value__c);
                        }   
                    }
                    //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
                    
                    if(mapLicenceTypeDPSSLM.ContainsKey(instOfOpp.License_Type__c)){    
                        //if(mapDeciTotalYear1DPSSLM.containsKey(instOfOpp.Id)){ - commented as not being calculated for all opportunities under same contract number
                        if(mapDeciTotalYear1DPSSLM.containsKey(instOfOpp.Contract_Number_New__c)){ 
                            Decimal deci =  mapDeciTotalYear1DPSSLM.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + instOfOpp.New_Amount__c;
                            mapDeciTotalYear1DPSSLM.put(instOfOpp.Contract_Number_New__c,deci); 
                        }else{
                            mapDeciTotalYear1DPSSLM.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        }
                    }
                    
                    if(mapLicenceType.ContainsKey(instOfOpp.License_Type__c)){
                        if(mapDeciTotalYear1CSN.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear1CSN.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + instOfOpp.New_Amount__c;
                            mapDeciTotalYear1CSN.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear1CSN.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        }
                    }
                    
                    if(counterFTRCheck > 0){
                        if(mapDeciTotalYear1FTR.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear1FTR.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterFTR;
                            mapDeciTotalYear1FTR.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear1FTR.put(instOfOpp.Contract_Number_New__c,counterFTR);
                        }
                    }
                    
                    if(counterDGBCheck > 0){
                        if(mapDeciTotalYear1DGB.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear1DGB.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterDGB;
                            mapDeciTotalYear1DGB.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear1DGB.put(instOfOpp.Contract_Number_New__c,counterDGB);
                        }
                    }
                    
                    //New TCV creation concept for CSN and DPS types
                    if(counterCSNCheck > 0){
                        if(mapDeciTotalYear1CSN.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear1CSN.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterCSN;
                            mapDeciTotalYear1CSN.put(instOfOpp.Contract_Number_New__c,deci);    
                        }
                    }
                    if(counterDPSLMCheck > 0){
                        if(mapDeciTotalYear1DPSSLM.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear1DPSSLM.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterDPSLM;
                            mapDeciTotalYear1DPSSLM.put(instOfOpp.Contract_Number_New__c,deci); 
                        }
                    }
                    //New TCV creation concept for CSN and DPS types
                }
                
                if(instOfOpp.Deal_Year__c == '2'){
                    
                    //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
                    if(instOfOpp.Price_Adjustment__c!= null){
                        if(mapPriceAdjYear2.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal instDeci = mapPriceAdjYear2.get(instOfOpp.Contract_Number_New__c);
                            instDeci = instDeci + instOfOpp.Price_Adjustment__c;
                            mapPriceAdjYear2.put(instOfOpp.Contract_Number_New__c,instDeci);
                        }else{
                            mapPriceAdjYear2.put(instOfOpp.Contract_Number_New__c,instOfOpp.Price_Adjustment__c);
                        }   
                    }
                    system.debug('mapPriceAdjYear2++'+mapPriceAdjYear2);
                    if(instOfOpp.Counted_sales_Cancellation_Value__c != null){
                        if(mapCancellYear2.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal instDeci = mapCancellYear2.get(instOfOpp.Contract_Number_New__c);
                            instDeci = instDeci + instOfOpp.Counted_sales_Cancellation_Value__c;
                            mapCancellYear2.put(instOfOpp.Contract_Number_New__c,instDeci);
                        }else{
                            mapCancellYear2.put(instOfOpp.Contract_Number_New__c,instOfOpp.Counted_sales_Cancellation_Value__c);
                        }   
                    }
                    //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
                    
                    if(mapLicenceTypeDPSSLM.ContainsKey(instOfOpp.License_Type__c)){    
                        if(mapDeciTotalYear2DPSSLM.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear2DPSSLM.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + instOfOpp.New_Amount__c;
                            mapDeciTotalYear2DPSSLM.put(instOfOpp.Contract_Number_New__c,deci); 
                        }else{
                            mapDeciTotalYear2DPSSLM.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        }
                    }
                    
                    if(mapLicenceType.ContainsKey(instOfOpp.License_Type__c)){
                        if(mapDeciTotalYear2CSN.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear2CSN.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + instOfOpp.New_Amount__c;
                            mapDeciTotalYear2CSN.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear2CSN.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        }
                    }
                    
                    if(counterFTRCheck > 0){
                        if(mapDeciTotalYear2FTR.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear2FTR.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterFTR;
                            mapDeciTotalYear2FTR.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear2FTR.put(instOfOpp.Contract_Number_New__c,counterFTR);
                        }
                    }
                    
                    if(counterDGBCheck > 0){
                        if(mapDeciTotalYear2DGB.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear2DGB.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterDGB;
                            mapDeciTotalYear2DGB.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear2DGB.put(instOfOpp.Contract_Number_New__c,counterDGB);
                        }
                    }
                    
                    //New TCV creation concept for CSN and DPS types
                    if(counterCSNCheck > 0){
                        if(mapDeciTotalYear2CSN.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear2CSN.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterCSN;
                            mapDeciTotalYear2CSN.put(instOfOpp.Contract_Number_New__c,deci);    
                        }
                    }
                    if(counterDPSLMCheck > 0){
                        if(mapDeciTotalYear2DPSSLM.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear2DPSSLM.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterDPSLM;
                            mapDeciTotalYear2DPSSLM.put(instOfOpp.Contract_Number_New__c,deci); 
                        }
                    }
                    //New TCV creation concept for CSN and DPS types
                }
                
                if(instOfOpp.Deal_Year__c == '3'){
                    //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
                    if(instOfOpp.Price_Adjustment__c!= null){
                        if(mapPriceAdjYear3.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal instDeci = mapPriceAdjYear3.get(instOfOpp.Contract_Number_New__c);
                            instDeci = instDeci + instOfOpp.Price_Adjustment__c;
                            mapPriceAdjYear3.put(instOfOpp.Contract_Number_New__c,instDeci);
                        }else{
                            mapPriceAdjYear3.put(instOfOpp.Contract_Number_New__c,instOfOpp.Price_Adjustment__c);
                        }   
                    }
                    
                    if(instOfOpp.Counted_sales_Cancellation_Value__c != null){
                        if(mapCancellYear3.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal instDeci = mapCancellYear3.get(instOfOpp.Contract_Number_New__c);
                            instDeci = instDeci + instOfOpp.Counted_sales_Cancellation_Value__c;
                            mapCancellYear3.put(instOfOpp.Contract_Number_New__c,instDeci);
                        }else{
                            mapCancellYear3.put(instOfOpp.Contract_Number_New__c,instOfOpp.Counted_sales_Cancellation_Value__c);
                        }   
                    }
                    //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
                    if(mapLicenceTypeDPSSLM.ContainsKey(instOfOpp.License_Type__c)){    
                        if(mapDeciTotalYear3DPSSLM.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear3DPSSLM.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + instOfOpp.New_Amount__c;
                            mapDeciTotalYear3DPSSLM.put(instOfOpp.Contract_Number_New__c,deci); 
                        }else{
                            mapDeciTotalYear3DPSSLM.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        }
                    }
                    
                    if(mapLicenceType.ContainsKey(instOfOpp.License_Type__c)){
                        if(mapDeciTotalYear3CSN.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear3CSN.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + instOfOpp.New_Amount__c;
                            mapDeciTotalYear3CSN.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear3CSN.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        }
                    }
                    
                    if(counterFTRCheck > 0){
                        if(mapDeciTotalYear3FTR.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear3FTR.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterFTR;
                            mapDeciTotalYear3FTR.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear3FTR.put(instOfOpp.Contract_Number_New__c,counterFTR);
                        }
                    }
                    
                    if(counterDGBCheck > 0){
                        if(mapDeciTotalYear3DGB.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear3DGB.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterDGB;
                            mapDeciTotalYear3DGB.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear3DGB.put(instOfOpp.Contract_Number_New__c,counterDGB);
                        }
                    }
                    
                    //New TCV creation concept for CSN and DPS types
                    if(counterCSNCheck > 0){
                        if(mapDeciTotalYear3CSN.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear3CSN.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterCSN;
                            mapDeciTotalYear3CSN.put(instOfOpp.Contract_Number_New__c,deci);    
                        }
                    }
                    if(counterDPSLMCheck > 0){
                        if(mapDeciTotalYear3DPSSLM.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear3DPSSLM.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterDPSLM;
                            mapDeciTotalYear3DPSSLM.put(instOfOpp.Contract_Number_New__c,deci); 
                        }
                    }
                    //New TCV creation concept for CSN and DPS types
                }
                
                if(instOfOpp.Deal_Year__c == '4'){
                    //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
                    if(mapPriceAdjYear4.containsKey(instOfOpp.Contract_Number_New__c)){
                        Decimal instDeci = mapPriceAdjYear4.get(instOfOpp.Contract_Number_New__c);
                        instDeci = instDeci + instOfOpp.Price_Adjustment__c;
                        mapPriceAdjYear4.put(instOfOpp.Contract_Number_New__c,instDeci);
                    }else{
                        mapPriceAdjYear4.put(instOfOpp.Contract_Number_New__c,instOfOpp.Price_Adjustment__c);
                    }
                    
                    if(instOfOpp.Counted_sales_Cancellation_Value__c != null){
                        if(mapCancellYear4.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal instDeci = mapCancellYear4.get(instOfOpp.Contract_Number_New__c);
                            instDeci = instDeci + instOfOpp.Counted_sales_Cancellation_Value__c;
                            mapCancellYear4.put(instOfOpp.Contract_Number_New__c,instDeci);
                        }else{
                            mapCancellYear4.put(instOfOpp.Contract_Number_New__c,instOfOpp.Counted_sales_Cancellation_Value__c);
                        }   
                    }
                    //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
                    
                    if(mapLicenceTypeDPSSLM.ContainsKey(instOfOpp.License_Type__c)){    
                        if(mapDeciTotalYear4DPSSLM.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear4DPSSLM.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + instOfOpp.New_Amount__c;
                            mapDeciTotalYear4DPSSLM.put(instOfOpp.Contract_Number_New__c,deci); 
                        }else{
                            mapDeciTotalYear4DPSSLM.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        }
                    }
                    
                    
                    if(mapLicenceType.ContainsKey(instOfOpp.License_Type__c)){
                        if(mapDeciTotalYear4CSN.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear4CSN.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + instOfOpp.New_Amount__c;
                            mapDeciTotalYear4CSN.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear4CSN.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        }
                    }
                    
                    if(counterFTRCheck > 0){
                        if(mapDeciTotalYear4FTR.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear4FTR.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterFTR;
                            mapDeciTotalYear4FTR.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear4FTR.put(instOfOpp.Contract_Number_New__c,counterFTR);
                        }
                    }
                    
                    if(counterDGBCheck > 0){
                        if(mapDeciTotalYear4DGB.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear4DGB.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterDGB;
                            mapDeciTotalYear4DGB.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear4DGB.put(instOfOpp.Contract_Number_New__c,counterDGB);
                        }
                    }
                    
                    //New TCV creation concept for CSN and DPS types
                    if(counterCSNCheck > 0){
                        if(mapDeciTotalYear4CSN.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear4CSN.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterCSN;
                            mapDeciTotalYear4CSN.put(instOfOpp.Contract_Number_New__c,deci);    
                        }
                    }
                    if(counterDPSLMCheck > 0){
                        if(mapDeciTotalYear4DPSSLM.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear4DPSSLM.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterDPSLM;
                            mapDeciTotalYear4DPSSLM.put(instOfOpp.Contract_Number_New__c,deci); 
                        }
                    }
                    //New TCV creation concept for CSN and DPS types
                }
                
                if(instOfOpp.Deal_Year__c == '5'){
                    //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
                    if(mapPriceAdjYear5.containsKey(instOfOpp.Contract_Number_New__c)){
                        Decimal instDeci = mapPriceAdjYear5.get(instOfOpp.Contract_Number_New__c);
                        instDeci = instDeci + instOfOpp.Price_Adjustment__c;
                        mapPriceAdjYear5.put(instOfOpp.Contract_Number_New__c,instDeci);
                    }else{
                        mapPriceAdjYear5.put(instOfOpp.Contract_Number_New__c,instOfOpp.Price_Adjustment__c);
                    }
                    
                    if(instOfOpp.Counted_sales_Cancellation_Value__c != null){
                        if(mapCancellYear5.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal instDeci = mapCancellYear5.get(instOfOpp.Contract_Number_New__c);
                            instDeci = instDeci + instOfOpp.Counted_sales_Cancellation_Value__c;
                            mapCancellYear5.put(instOfOpp.Contract_Number_New__c,instDeci);
                        }else{
                            mapCancellYear5.put(instOfOpp.Contract_Number_New__c,instOfOpp.Counted_sales_Cancellation_Value__c);
                        }   
                    }
                    //Adjusting the cancellation amount Counted_sales_Cancellation_Value__c
                    
                    if(mapLicenceTypeDPSSLM.ContainsKey(instOfOpp.License_Type__c)){    
                        //if(mapDeciTotalYear5DPSSLM.containsKey(instOfOpp.Id)){ - commented as id being used to check the key instead of Contract Number
                        if(mapDeciTotalYear5DPSSLM.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear5DPSSLM.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + instOfOpp.New_Amount__c;
                            mapDeciTotalYear5DPSSLM.put(instOfOpp.Contract_Number_New__c,deci); 
                        }else{
                            mapDeciTotalYear5DPSSLM.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        }
                    }
                    
                    if(mapLicenceType.ContainsKey(instOfOpp.License_Type__c)){
                        //if(mapDeciTotalYear5CSN.containsKey(instOfOpp.Id)){ - commented as id being used to check the key instead of Contract Number
                        if(mapDeciTotalYear5CSN.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear5CSN.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + instOfOpp.New_Amount__c;
                            mapDeciTotalYear5CSN.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear5CSN.put(instOfOpp.Contract_Number_New__c,instOfOpp.New_Amount__c);
                        }
                    }
                    
                    if(counterFTRCheck > 0){
                        //if(mapDeciTotalYear5FTR.containsKey(instOfOpp.Id)){ - commented as id being used to check the key instead of Contract Number
                        if(mapDeciTotalYear5FTR.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear5FTR.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterFTR;
                            mapDeciTotalYear5FTR.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear5FTR.put(instOfOpp.Contract_Number_New__c,counterFTR);
                        }
                    }
                    
                    if(counterDGBCheck > 0){
                        //if(mapDeciTotalYear5DGB.containsKey(instOfOpp.Id)){ - commented as id being used to check the key instead of Contract Number
                        if(mapDeciTotalYear5DGB.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear5DGB.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterDGB;
                            mapDeciTotalYear5DGB.put(instOfOpp.Contract_Number_New__c,deci);    
                        }else{
                            mapDeciTotalYear5DGB.put(instOfOpp.Contract_Number_New__c,counterDGB);
                        }
                    }
                    
                    //New TCV creation concept for CSN and DPS types
                    if(counterCSNCheck > 0){
                        if(mapDeciTotalYear5CSN.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear5CSN.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterCSN;
                            mapDeciTotalYear5CSN.put(instOfOpp.Contract_Number_New__c,deci);    
                        }
                    }
                    if(counterDPSLMCheck > 0){
                        if(mapDeciTotalYear5DPSSLM.containsKey(instOfOpp.Contract_Number_New__c)){
                            Decimal deci =  mapDeciTotalYear5DPSSLM.get(instOfOpp.Contract_Number_New__c);
                            deci = deci + counterDPSLM;
                            mapDeciTotalYear5DPSSLM.put(instOfOpp.Contract_Number_New__c,deci); 
                        }
                    }
                    //New TCV creation concept for CSN and DPS types
                }
                
                //To get Yearly Totals for CSN ,DGB,DPSSLM,FTR
            }else{
            //For CSN
                for(Feature_Set__c instOfFeat :  instOfOpp.Feature_Sets__r){
                    // Feature value null on Feature sets
                    if(instOfFeat.Feature__c != null && instOfFeat.Feature__c != ''){
                    // Feature value null on Feature sets
                      if(mapPickValAssign.containsKey(instOfFeat.Feature__c.trim())){
                          if(mapPickValAssign.get(instOfFeat.Feature__c.trim()) == 'Straightline'){
                              //if(instOfOpp.Product__c != 'CSN'){
                                  if(mapIdDeciStraight.containskey(instOfOpp.Contract_Number_New__c)){
                                      Decimal instOfDeci = mapIdDeciStraight.get(instOfOpp.Contract_Number_New__c);
                                      instOfDeci = instOfDeci + instOfFeat.Total_Fees__c;
                                      mapIdDeciStraight.put(instOfOpp.Contract_Number_New__c,instOfDeci);
                                  }else{
                                      mapIdDeciStraight.put(instOfOpp.Contract_Number_New__c,instOfFeat.Total_Fees__c);
                                      mapStraightCheck.put(instOfOpp.Contract_Number_New__c,instOfOpp.Contract_Number_New__c);
                                  }
                                  if(mapOppIdFeat.ContainsKey(instOfOpp.Id)){
                                      Decimal instOfDeci = mapOppIdFeat.get(instOfOpp.Id);
                                      instOfDeci = instOfDeci + instOfFeat.Total_Fees__c;
                                      mapOppIdFeat.put(instOfOpp.Id,instOfDeci);
                                  }else{
                                      mapOppIdFeat.put(instOfOpp.Id,instOfFeat.Total_Fees__c);
                                  }   
                              //}
                          }else if(mapPickValAssign.get(instOfFeat.Feature__c.trim()) == 'Milestone'){
                              if(mapIdDeciMil.containskey(instOfOpp.Contract_Number_New__c)){
                                  Decimal instOfDeci = mapIdDeciMil.get(instOfOpp.Contract_Number_New__c);
                                  instOfDeci = instOfDeci + instOfFeat.Total_Fees__c;
                                  mapIdDeciMil.put(instOfOpp.Contract_Number_New__c,instOfDeci);
                              }else{
                                  mapIdDeciMil.put(instOfOpp.Contract_Number_New__c,instOfFeat.Total_Fees__c);
                                  mapMilestoneCheck.put(instOfOpp.Contract_Number_New__c,instOfOpp.Contract_Number_New__c);
                              }
                          }   
                      }
                    }
                }
            }
        }
    }
    
}