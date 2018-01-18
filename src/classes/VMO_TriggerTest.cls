@isTest
public class VMO_TriggerTest {
    static testmethod void VMO_TriggerTest(){
        
       //Insert Account
       Account testacc = new Account();
       ID vendRecId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
       testacc.RecordTypeId = vendRecId;
       testacc.Name = 'Test Account';
       insert testacc;  
       VMO_AccountTriggerHelper.run= true;
       Account acc = [Select Stratification_Value__c,Total_Spend__c from Account where id=:testacc.id limit 1];
       system.assertEquals(acc.Stratification_Value__c, null);
        
       //Insert Contract 
       Contract__c testcon = new Contract__c();
       ID conRecId = Schema.SObjectType.Contract__c.getRecordTypeInfosByName().get('Contract').getRecordTypeId();
       testcon.RecordTypeId = conRecId;
       testcon.Award_Type__c = 'Definitive Contract';
       testcon.Vendor__c = testacc.Id;
       testcon.name = 'Test Contract';
       testcon.Base_and_All_Options__c = 500;
       testcon.Mission_Critical__c = 'HR';
       testcon.Key_Priorities__c = 'Cloud First';
       Insert testcon;
       VMO_AccountTriggerHelper.run= true;
  
       //Insert Task Order
       Task_Order__c testto = new Task_Order__c();
       ID toRecID = Schema.SObjectType.Task_Order__c.getRecordTypeInfosByName().get('Task Order').getRecordTypeId();
       testto.RecordTypeId = toRecID;
       testto.Vendor__c = testacc.Id;
       testto.Name ='TestTo';
       testto.Award_Type__c = 'Delivery Order';
       testto.Base_and_All_Options__c = 100;
       testto.Mission_Critical__c='HR';
       insert testto;
       VMO_AccountTriggerHelper.run= true;
       
       // Insert BPA
       BPA__c testbpa = new BPA__c();
       ID bpaRecID = Schema.SObjectType.BPA__c.getRecordTypeInfosByName().get('BPA').getRecordTypeId();
       testbpa.RecordTypeId = bpaRecID;
       testbpa.Vendor__c = testacc.Id;
       testbpa.Name = 'Test BPA';
       testbpa.Award_Type__c = 'BPA';
       insert testbpa;
       VMO_AccountTriggerHelper.run= true;
       
       //Insert BPA Calls
       BPA_Call__c testbpacall = new BPA_Call__c();
       ID bpacallRecID = Schema.SObjectType.BPA_Call__c.getRecordTypeInfosByName().get('BPA Call').getRecordTypeId();
       testbpacall.RecordTypeId = bpacallRecID;
       testbpacall.BPA_Name__c = testbpa.id;
       testbpacall.Name = 'Test BPA Call';
       testbpacall.Base_and_All_Options__c = 500;
       testbpacall.Mission_Critical__c='HR';
       testbpacall.Innovative__c=true;
       insert testbpacall;
       VMO_AccountTriggerHelper.run= true;
       
       Account objAcct = [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+objAcct.Stratification_Value__c);       
       system.assertEquals(objAcct.Stratification_Value__c, 'Sustaining');
       system.assertEquals(objAcct.Total_No_of_Contracts__c, 1);
       system.assertEquals(objAcct.Total_No_of_TaskOrders__c, 1);
       system.assertEquals(objAcct.Total_No_of_BPA__c, 1);
       system.assertEquals(objAcct.Total_No_of_BPACalls__c, 1);
       system.assertEquals(objAcct.Total_Spend__c, 1100);
       
       //Account update
       update testacc;
       VMO_AccountTriggerHelper.run= true;
        
       //update contract strat value to critical from sustaining and base all option to 0 from 500
       testcon.Mission_Critical__c = 'HR';
       testcon.Key_Priorities__c = 'Cloud First';
       testcon.Innovative__c = true;
       testcon.Base_and_All_Options__c = 0;
       update testcon;
       VMO_AccountTriggerHelper.run= true;  
       
       //update task order strat value to critical from sustaining and base all option to 100 from 200
       testto.Base_and_All_Options__c = 200;
       testto.Mission_Critical__c='HR';
       testto.Innovative__c = true;
       testto.Key_Priorities__c = 'cloud First';
       update testto;
       VMO_AccountTriggerHelper.run= true;
       
       //update BPA 
       testbpa.Name = 'Test BPA update';
       testbpa.Award_Type__c = 'BPA';
       update testbpa;
       VMO_AccountTriggerHelper.run= true;
       
       //update BPA Call  base all option to 600 from 500
       testbpacall.Base_and_All_Options__c = 600;
       update testbpacall;
       VMO_AccountTriggerHelper.run= true;
       
       Account objAcct1= [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+objAcct1.Stratification_Value__c);       
       system.assertEquals(objAcct1.Stratification_Value__c, 'Critical');
       system.assertEquals(objAcct1.Total_No_of_Contracts__c, 1);
       system.assertEquals(objAcct1.Total_No_of_TaskOrders__c, 1);
       system.assertEquals(objAcct1.Total_No_of_BPA__c, 1);
       system.assertEquals(objAcct1.Total_No_of_BPACalls__c, 1);
       system.assertEquals(objAcct1.Total_Spend__c, 800);
       
       //reduce  Base all amount
       testcon.Base_and_All_Options__c = 100;
       update testcon;
       VMO_AccountTriggerHelper.run= true;
       
       testto.Base_and_All_Options__c = 0;
       update testto;
       system.debug('testtobase'+testto.Base_and_All_Options__c);
       VMO_AccountTriggerHelper.run= true; 
       
       testbpacall.Base_and_All_Options__c = 0;
       update testbpacall;
       VMO_AccountTriggerHelper.run= true; 
       
        Account objAcc= [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+objAcc.Stratification_Value__c);       
       system.assertEquals(objAcc.Stratification_Value__c, 'Critical');
       system.assertEquals(objAcc.Total_Spend__c, 100); 
       
        //update strat rating to strategic
        
         //update  strat value to strategic from critical
       testcon.Mission_Critical__c = 'HR';
       testcon.Key_Priorities__c = 'Cloud First';
       testcon.Innovative__c = true;
       testcon.Limited_Sources__c=true;
       update testcon;
       VMO_AccountTriggerHelper.run= true;
        
       testto.Mission_Critical__c = 'HR';
       testto.Key_Priorities__c = 'Cloud First';
       testto.Innovative__c = true;
       testto.Limited_Sources__c=true;
       update testto;
       VMO_AccountTriggerHelper.run= true;
       
       testbpacall.Mission_Critical__c = 'HR';
       testbpacall.Key_Priorities__c = 'Cloud First';
       testbpacall.Innovative__c = true;
       testbpacall.Limited_Sources__c=true;
       update testbpacall;
       VMO_AccountTriggerHelper.run= true;        
       
        Account obj= [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       
       system.debug('******'+obj.Stratification_Value__c);       
       system.assertEquals(obj.Stratification_Value__c, 'Strategic'); 
       
       testacc.Stratification_Value_Override__c = 'Standard';
       update testacc;
       VMO_AccountTriggerHelper.run= true;
       Account obj1= [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+obj1.Stratification_Value__c);       
       system.assertEquals(obj1.Stratification_Value__c, 'Standard');   
   
       //Delete Action
       delete testcon;
       VMO_AccountTriggerHelper.run= true;
       delete testto;
       VMO_AccountTriggerHelper.run= true;
       delete testbpacall;
       VMO_AccountTriggerHelper.run= true;
       delete testbpa;
       VMO_AccountTriggerHelper.run= true;
        
       Account objAcct2= [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+objAcct2.Stratification_Value__c);       
       system.assertEquals(objAcct2.Stratification_Value__c, 'Standard');
       system.assertEquals(objAcct2.Total_No_of_Contracts__c, 0);
       system.assertEquals(objAcct2.Total_No_of_TaskOrders__c, 0);
       system.assertEquals(objAcct2.Total_No_of_BPA__c, 0);
       system.assertEquals(objAcct2.Total_No_of_BPACalls__c, 0);
       system.assertEquals(objAcct2.Total_Spend__c, 0);
      
    }
    static  testmethod void VMO_Accounttriggertest(){
       Account testacc = new Account();
       ID vendRecId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
       testacc.RecordTypeId = vendRecId;
       testacc.Name = 'Test Account';
       insert testacc;  
       VMO_AccountTriggerHelper.run= true;
       
       //Insert Contract 
       Contract__c testcon = new Contract__c();
       ID conRecId = Schema.SObjectType.Contract__c.getRecordTypeInfosByName().get('Contract').getRecordTypeId();
       testcon.RecordTypeId = conRecId;
       testcon.Award_Type__c = 'Definitive Contract';
       testcon.Vendor__c = testacc.Id;
       testcon.name = 'Test Contract';
       testcon.Base_and_All_Options__c = 500;
       testcon.Mission_Critical__c = 'HR';
       testcon.Key_Priorities__c = 'Cloud First';
       testcon.Innovative__c = true;
        Insert testcon;
       VMO_AccountTriggerHelper.run= true;
        
       update testacc;
       VMO_AccountTriggerHelper.run = true;
       Account objAcct = [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+objAcct.Stratification_Value__c);       
       system.assertEquals(objAcct.Stratification_Value__c, 'Critical');
        
       testcon.Innovative__c = false;
       update testcon;
       VMO_AccountTriggerHelper.run= true;
       update testacc;
        VMO_AccountTriggerHelper.run= true;
        Account objAcc = [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+objAcc.Stratification_Value__c);       
       system.assertEquals(objAcc.Stratification_Value__c, 'Sustaining');
       
       testcon.Innovative__c = true;
       testcon.Limited_Sources__c= true;
       update testcon;
       VMO_AccountTriggerHelper.run= true;
       update testacc;
        VMO_AccountTriggerHelper.run= true;
        Account objAc = [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+objAc.Stratification_Value__c);       
       system.assertEquals(objAc.Stratification_Value__c, 'Strategic');
       
        testcon.Mission_Critical__c = '';
        testcon.Key_Priorities__c = '';
        testcon.Innovative__c = false;
        update testcon;
        VMO_AccountTriggerHelper.run= true;
        update testacc;
        VMO_AccountTriggerHelper.run= true;
        
        Account objAcct1 = [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+objAcct1.Stratification_Value__c);       
       system.assertEquals(objAcct1.Stratification_Value__c, 'Standard');
        
        testacc.Stratification_Value_Override__c = 'Standard';
        update testacc;
        VMO_AccountTriggerHelper.run= true;
        Account obj = [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+obj.Stratification_Value__c);       
       system.assertEquals(obj.Stratification_Value__c, 'Standard');
        
      Account testacc1 = new Account();
       testacc1.RecordTypeId = vendRecId;
       testacc1.Name = 'Test Account2';
       testacc1.Stratification_Value_Override__c='Standard';
       insert testacc1;  
       VMO_AccountTriggerHelper.run= true;
       Account obj1 = [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+obj1.Stratification_Value__c);       
       system.assertEquals(obj1.Stratification_Value__c, 'Standard');
       
       delete testcon;
       VMO_AccountTriggerHelper.run= true;
       testacc.Stratification_Value_Override__c = '';
       update testacc;
       VMO_AccountTriggerHelper.run= true;
       
        Account obj2 = [Select Total_No_of_Contracts__c, Total_No_of_TaskOrders__c, Total_No_of_BPA__c,
                   Total_No_of_BPACalls__c, Total_Spend__c, Stratification_Value__c
                   from Account where id=:testacc.id limit 1];
       system.debug('******'+obj2.Stratification_Value__c);       
       system.assertEquals(obj2.Stratification_Value__c, null);  
    }
    
  static testmethod void VMO_BPAtriggertest(){
       Account testacc = new Account();
       ID vendRecId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
       testacc.RecordTypeId = vendRecId;
       testacc.Name = 'Test Account';
       testacc.Total_Spend__c = null;
       insert testacc;  
       VMO_AccountTriggerHelper.run= true;
        //case 1    
       // Insert BPA 1
       BPA__c testbpa = new BPA__c();
       ID bpaRecID = Schema.SObjectType.BPA__c.getRecordTypeInfosByName().get('BPA').getRecordTypeId();
       testbpa.RecordTypeId = bpaRecID;
       testbpa.Vendor__c = testacc.Id;
       testbpa.Name = 'Test BPA';
       testbpa.Award_Type__c = 'BPA';
       insert testbpa;
       VMO_AccountTriggerHelper.run= true;
      //insert bpa call1
       BPA_Call__c testbpacall = new BPA_Call__c();
       ID bpacallRecID = Schema.SObjectType.BPA_Call__c.getRecordTypeInfosByName().get('BPA Call').getRecordTypeId();
       testbpacall.RecordTypeId = bpacallRecID;
       testbpacall.BPA_Name__c = testbpa.id;
       testbpacall.Name = 'Test BPA Call';
       testbpacall.Base_and_All_Options__c = 500;
       testbpacall.Key_Priorities__c = 'Cloud First'; //strat standard
       insert testbpacall;
       VMO_AccountTriggerHelper.run= true;
      
      BPA__c objbpa = [Select Total_Number_of_BPA_Calls__c from BPA__c where id=:testbpa.id];
            Account obj = [Select Total_Spend__c, Stratification_Value__c,Total_No_of_BPACalls__c
                            from Account where id=:testacc.id limit 1];     
      system.assertEquals(obj.Total_Spend__c, 500);
      system.assertEquals(obj.Stratification_Value__c, 'Standard');
      system.assertEquals(obj.Total_No_of_BPACalls__c, objbpa.Total_Number_of_BPA_Calls__c);
      system.assertEquals(objbpa.Total_Number_of_BPA_Calls__c, 1);

      
      //Insert BPA 2
       BPA__c testbpa2 = new BPA__c();
       testbpa2.RecordTypeId = bpaRecID;
       testbpa2.Vendor__c = testacc.Id;
       testbpa2.Name = 'Test BPA2';
       testbpa2.Award_Type__c = 'BPA';
       insert testbpa2;
       VMO_AccountTriggerHelper.run= true;
      
      //Insert BPA call
       BPA_Call__c testbpacall2 = new BPA_Call__c();
       testbpacall2.RecordTypeId = bpacallRecID;
       testbpacall2.BPA_Name__c = testbpa2.id;
       testbpacall2.Name = 'Test BPA Call2';
       testbpacall2.Base_and_All_Options__c = 500;
       testbpacall2.Key_Priorities__c = 'Cloud First';
       testbpacall2.Innovative__c = true;
       insert testbpacall2;
       VMO_AccountTriggerHelper.run= true;
      BPA__c objbpa1 = [Select Total_Number_of_BPA_Calls__c from BPA__c where id=:testbpa2.id];
            Account obj1 = [Select Total_Spend__c, Stratification_Value__c,Total_No_of_BPACalls__c
                            from Account where id=:testacc.id limit 1];     
      system.assertEquals(obj1.Total_Spend__c, 1000);
      system.assertEquals(obj1.Stratification_Value__c, 'Sustaining');
      system.assertEquals(obj1.Total_No_of_BPACalls__c, 2);
      system.assertEquals(objbpa1.Total_Number_of_BPA_Calls__c, 1);
      
      //Insert BPA 3
      BPA__c testbpa3 = new BPA__c();
       testbpa3.RecordTypeId = bpaRecID;
       testbpa3.Vendor__c = testacc.Id;
       testbpa3.Name = 'Test BPA3';
       testbpa3.Award_Type__c = 'BPA';
       insert testbpa3;
       VMO_AccountTriggerHelper.run= true;
      //Insert BPA call
       BPA_Call__c testbpacall3 = new BPA_Call__c();
       testbpacall3.RecordTypeId = bpacallRecID;
       testbpacall3.BPA_Name__c = testbpa3.id;
       testbpacall3.Name = 'Test BPA Call3';
       testbpacall3.Base_and_All_Options__c = 500;
       testbpacall3.Key_Priorities__c = 'Cloud First';
       testbpacall3.Innovative__c = true;
       testbpacall3.Limited_Sources__c = true;
       insert testbpacall3;
       VMO_AccountTriggerHelper.run= true;
       BPA__c objbpa2 = [Select Total_Number_of_BPA_Calls__c from BPA__c where id=:testbpa3.id];
            Account obj3 = [Select Total_Spend__c, Stratification_Value__c,Total_No_of_BPACalls__c
                            from Account where id=:testacc.id limit 1];     
      system.assertEquals(obj3.Total_Spend__c, 1500);
      system.assertEquals(obj3.Stratification_Value__c, 'Critical');
      system.assertEquals(obj3.Total_No_of_BPACalls__c, 3);
      system.assertEquals(objbpa2.Total_Number_of_BPA_Calls__c, 1);
      
      //Insert BPA 4
       BPA__c testbpa4 = new BPA__c();
       testbpa4.RecordTypeId = bpaRecID;
       testbpa4.Vendor__c = testacc.Id;
       testbpa4.Name = 'Test BPA4';
       testbpa4.Award_Type__c = 'BPA';
       insert testbpa4;
       VMO_AccountTriggerHelper.run= true;
      //Insert BPA call
       BPA_Call__c testbpacall4 = new BPA_Call__c();
       testbpacall4.RecordTypeId = bpacallRecID;
       testbpacall4.BPA_Name__c = testbpa4.id;
       testbpacall4.Name = 'Test BPA Call4';
       testbpacall4.Base_and_All_Options__c = 500;
       testbpacall4.Key_Priorities__c = 'Cloud First';
       testbpacall4.Innovative__c = true;
       testbpacall4.Limited_Sources__c = true;
       testbpacall4.Mission_Critical__c = 'HR' ;
       insert testbpacall4;
       VMO_AccountTriggerHelper.run= true;
            
      BPA__c objbpa3 = [Select Total_Number_of_BPA_Calls__c from BPA__c where id=:testbpa4.id];
            Account obj4 = [Select Total_Spend__c, Stratification_Value__c,Total_No_of_BPACalls__c
                            from Account where id=:testacc.id limit 1];     
      system.assertEquals(obj4.Total_Spend__c, 2000);
      system.assertEquals(obj4.Stratification_Value__c, 'Strategic');
      system.assertEquals(obj4.Total_No_of_BPACalls__c, 4);
      system.assertEquals(objbpa3.Total_Number_of_BPA_Calls__c, 1);
      
      delete testbpacall4;
      VMO_AccountTriggerHelper.run= true;
      delete testbpa4;
      VMO_AccountTriggerHelper.run= true;
      Account obj5 = [Select Total_Spend__c, Stratification_Value__c,Total_No_of_BPACalls__c
                            from Account where id=:testacc.id limit 1]; 
       //system.assertEquals(obj4.Stratification_Value__c, 'Critical');
      
      delete testbpacall3;
      VMO_AccountTriggerHelper.run= true;
      delete testbpa3;
      VMO_AccountTriggerHelper.run= true;
      Account obj6 = [Select Total_Spend__c, Stratification_Value__c,Total_No_of_BPACalls__c
                            from Account where id=:testacc.id limit 1]; 
       //system.assertEquals(obj6.Stratification_Value__c, 'Sustaining');
      
      delete testbpacall2;
      VMO_AccountTriggerHelper.run= true;
      delete testbpa2;
      VMO_AccountTriggerHelper.run= true;
      Account obj7 = [Select Total_Spend__c, Stratification_Value__c,Total_No_of_BPACalls__c
                            from Account where id=:testacc.id limit 1]; 
       //system.assertEquals(obj7.Stratification_Value__c, 'Standard');
		
      delete testbpacall;
      VMO_AccountTriggerHelper.run= true;
      delete testbpa;
      VMO_AccountTriggerHelper.run= true;
      Account obj8 = [Select Total_Spend__c, Stratification_Value__c,Total_No_of_BPACalls__c
                            from Account where id=:testacc.id limit 1]; 
       system.assertEquals(obj8.Stratification_Value__c, null);
 
      testacc.Stratification_Value_Override__c = 'Strategic';
      update testacc;
      VMO_AccountTriggerHelper.run= true;
      Account obj2 = [Select Total_Spend__c, Stratification_Value__c,Total_No_of_BPACalls__c
                            from Account where id=:testacc.id limit 1];     
	  system.assertEquals(obj2.Stratification_Value__c, 'Strategic');
      //system.assertEquals(obj2.Total_Spend__c, -500);

	}
    static testmethod void VMO_taskOrdertriggertest(){
        //Insert Account 
         Account testacc = new Account();
       ID vendRecId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Vendor').getRecordTypeId();
       testacc.RecordTypeId = vendRecId;
       testacc.Name = 'Test Account';
       insert testacc;  
       VMO_AccountTriggerHelper.run= true;
        
         Task_Order__c testto = new Task_Order__c();
       ID toRecID = Schema.SObjectType.Task_Order__c.getRecordTypeInfosByName().get('Task Order').getRecordTypeId();
       testto.RecordTypeId = toRecID;
       testto.Vendor__c = testacc.Id;
       testto.Name ='TestTo';
       testto.Award_Type__c = 'Delivery Order';
       testto.Base_and_All_Options__c = 100;
       insert testto;
       VMO_AccountTriggerHelper.run= true;
        
       Account acc = [Select Stratification_Value__c from Account where id=:testacc.id] ;
        system.assertEquals(acc.Stratification_Value__c, 'Standard');
    }
    
}