@isTest 
Private class GLXY_CodeCoverageBudgetCall {
    
    static testMethod void testBCJobSchedule(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_CleanUpBudgetCallLineItems', cron, new GLXY_BC_JobSchedule());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule10(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_LoadProjectLumpSum', cron, new GLXY_BC_JobSchedule10());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule11(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();

        String jobId = System.schedule('GLXY_BC_LoadProjectStepRent', cron, new GLXY_BC_JobSchedule11());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule11b(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_LoadTaxes', cron, new GLXY_BC_JobSchedule11b());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule12(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
       
        String jobId = System.schedule('GLXY_BC_UpdateDelegatedFlag', cron, new GLXY_BC_JobSchedule12());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule13(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('Glxy_BC_GenerateFY1Projection', cron, new GLXY_BC_JobSchedule13());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule14(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('Glxy_BC_GenerateFY2Projection', cron, new GLXY_BC_JobSchedule14());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule15(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_GenerateFYTotals', cron, new GLXY_BC_JobSchedule15());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule15b(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_GenerateFYTotals2', cron, new GLXY_BC_JobSchedule15b());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
    }
    
    static testMethod void testBudgetCallJobSchedule15c(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_GenerateFYTotals3', cron, new GLXY_BC_JobSchedule15c());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule16(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_ComputeLeaseTotals', cron, new GLXY_BC_JobSchedule16());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule16a(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_ComputeLeaseTotals2', cron, new GLXY_BC_JobSchedule16a());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule16b(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_ComputeLeaseTotals3', cron, new GLXY_BC_JobSchedule16b());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule2(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_LoadLease', cron, new GLXY_BC_JobSchedule2());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule3(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_LoadCPI', cron, new GLXY_BC_JobSchedule3());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule4(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_LoadLumpSum', cron, new GLXY_BC_JobSchedule4());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
    }
    
    static testMethod void testBudgetCallJobSchedule5(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_LoadStepRent', cron, new GLXY_BC_JobSchedule5());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule6(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_LoadIBAA', cron, new GLXY_BC_JobSchedule6());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule7(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_LoadRWA', cron, new GLXY_BC_JobSchedule7());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule8(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_LoadDoubleRent', cron, new GLXY_BC_JobSchedule8());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    static testMethod void testBudgetCallJobSchedule9(){
        DateTime n = datetime.now().addMinutes(1);
        String cron = '';
        cron += n.second();
        cron += ' ' + n.minute();
        cron += ' ' + n.hour();
        cron += ' ' + n.day();
        cron += ' ' + n.month();
        cron += ' ' + '?';
        cron += ' ' + n.year();
        
        String jobId = System.schedule('GLXY_BC_LoadProject', cron, new GLXY_BC_JobSchedule9());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(cron, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
    
    
    static testMethod void testCleanUpBudgetCallLineItems(){
        
        Glxy_Lease__c objLease = new Glxy_Lease__c();
        objLease.Name = 'LAK05855';
        objLease.BaseLeaseEffectiveDate__c = Datetime.Now().Date();
        objLease.ExpirationDateofLease__c =Datetime.Now().Date();
        insert objLease;
        
        Glxy_BudgetCallLineItem__c objBudgetCall = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LAK05855',
            BudgetCategory__c = 'Base Rent'
            );
        insert objBudgetCall;
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
                
        Glxy_BC_CleanUpBudgetCallLineItems objTest = new Glxy_BC_CleanUpBudgetCallLineItems();
        Database.executeBatch(objTest);
        System.Assert(objTest!=NULL);     
   
    }  
    
    static testMethod void testGlxy_BC_GenerateFY1Projection(){
         Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LEASENO',
            BudgetCategory__c = 'Base Rent',
            SquareFeet__c = 10,
            CancellationSqFt__c = 0.00,
            ExpansionSqFt__c = 0.00,
            DataGroup__c = 'IA',
            IAConversionFY__c = '2099',
            LeaseStatus__c = 'Active',
            FiscalYear__c = String.ValueOf(Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year()));
        insert objBCEntry;
        
         Glxy_BudgetCallLineItem__c objBCEntry2 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LEASENO',
            BudgetCategory__c = 'Base Rent',
            SquareFeet__c = 10,
            CancellationSqFt__c = 0.00,
            ExpansionSqFt__c = 0.00,
            DataGroup__c = 'NOA',
            LeaseStatus__c = 'Active',
            FiscalYear__c = String.ValueOf(Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year()));
        insert objBCEntry2;
        
        System.Assert(objBCEntry!=NULL);
        
        Test.startTest();     
        Glxy_BC_GenerateFY1Projection objTest = new Glxy_BC_GenerateFY1Projection();
        Database.executeBatch(objTest);
        Glxy_BC_GenerateFY1ProjectionIA objTest2 = new Glxy_BC_GenerateFY1ProjectionIA();
        Database.executeBatch(objTest2);      
        Test.stopTest();
    }
    
    static testMethod void testGlxy_BC_GenerateFY2Projection(){
        
         Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LEASENO',
            BudgetCategory__c = 'Base Rent',
            RegionCode__c = '1',
            SquareFeet__c = 10,
            CancellationSqFt__c = 0.00,
            ExpansionSqFt__c = 0.00,
            DataGroup__c = 'IA',
            IAConversionFY__c = '2099',
            LeaseStatus__c = 'Active',
            FiscalYear__c = String.ValueOf(Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year()));
        insert objBCEntry;
        
        System.Assert(objBCEntry!=NULL);
        
         Glxy_BudgetCallLineItem__c objBCEntry2 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LEASENO',
            BudgetCategory__c = 'Base Rent',
             RegionCode__c = '1',
            SquareFeet__c = 10,
            CancellationSqFt__c = 0.00,
            ExpansionSqFt__c = 0.00,
            DataGroup__c = 'NOA',
            LeaseStatus__c = 'Active',
            FiscalYear__c = String.ValueOf(Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year()));
        insert objBCEntry2;
        
        Test.startTest();     
        Glxy_BC_GenerateFY2Projection objTest = new Glxy_BC_GenerateFY2Projection();
        Database.executeBatch(objTest);     
        Glxy_BC_GenerateFY2ProjectionIA objTest2 = new Glxy_BC_GenerateFY2ProjectionIA();
        Database.executeBatch(objTest2);      
        Test.stopTest(); 
    }
    
    static testMethod void testGlxy_BC_GenerateFY2bProjection(){
        
         Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LEASENO',
            BudgetCategory__c = 'Base Rent',
            RegionCode__c = '10',
            SquareFeet__c = 10,
            CancellationSqFt__c = 0.00,
            ExpansionSqFt__c = 0.00,
            DataGroup__c = 'IA',
            IAConversionFY__c = '2099',
            LeaseStatus__c = 'Active',
            FiscalYear__c = String.ValueOf(Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year()));
        insert objBCEntry;
        
        System.Assert(objBCEntry!=NULL);
        
         Glxy_BudgetCallLineItem__c objBCEntry2 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LEASENO',
            BudgetCategory__c = 'Base Rent',
             RegionCode__c = '10',
            SquareFeet__c = 10,
            CancellationSqFt__c = 0.00,
            ExpansionSqFt__c = 0.00,
            DataGroup__c = 'NOA',
            LeaseStatus__c = 'Active',
            FiscalYear__c = String.ValueOf(Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year()));
        insert objBCEntry2;
        
        Test.startTest();     
        Glxy_BC_GenerateFY2bProjection objTest = new Glxy_BC_GenerateFY2bProjection();
        Database.executeBatch(objTest);     
        Glxy_BC_GenerateFY2bProjectionIA objTest2 = new Glxy_BC_GenerateFY2bProjectionIA();
        Database.executeBatch(objTest2);      
        Test.stopTest(); 
    }
    
    static testMethod void testGlxy_BC_GenerateFYTotals(){
         Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'Unassigned',
            BudgetCategory__c = 'Base Rent',
            SquareFeet__c = 10,
            DataGroup__c = 'IA',
            FiscalYear__c = String.ValueOf(Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year()));
        insert objBCEntry;
        System.Assert(objBCEntry!=NULL);
        
        //Test.startTest();     
        Glxy_BC_GenerateFYTotals objTest = new Glxy_BC_GenerateFYTotals();
        Database.executeBatch(objTest);      
        //Test.stopTest();    
    }
    
    static testMethod void testGlxy_BC_GenerateFYTotals2(){
        Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'Unassigned',
            BudgetCategory__c = 'Base Rent',
            SquareFeet__c = 10,
            DataGroup__c = 'IA',
            FiscalYear__c = String.ValueOf(Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 2 : Datetime.Now().Date().Year() + 1));
        insert objBCEntry;
        System.Assert(objBCEntry!=NULL);
        
        //Test.startTest();     
        Glxy_BC_GenerateFYTotals2 objTest = new Glxy_BC_GenerateFYTotals2();
        Database.executeBatch(objTest);      
        //Test.stopTest();   
    }
    
    static testMethod void testGlxy_BC_GenerateFYTotals3(){
        Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
           LeaseNumber__c = 'Unassigned',
            BudgetCategory__c = 'Base Rent',
            SquareFeet__c = 10,
            DataGroup__c = 'IA',
            FiscalYear__c = String.ValueOf(Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 3 : Datetime.Now().Date().Year() + 2));
        insert objBCEntry;
        System.Assert(objBCEntry!=NULL);
        
        //Test.startTest();     
        Glxy_BC_GenerateFYTotals3 objTest = new Glxy_BC_GenerateFYTotals3();
        Database.executeBatch(objTest);      
        //Test.stopTest();     
    }
    
    static testMethod void testGLXY_BC_LoadCPI(){
        
        Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
            StatusCode__c='Active',
            BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
            ExpirationDateofLease__c=Datetime.Now().Date().addYears(10),
            IAConverstionDate__c=Datetime.Now().Date().addYears(2),
            RegionCD__c='11',
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            name='testte',
            Next_FY_Leases__c = False,
            BaseAnnualRent__c = 2222);
        insert objleaseEntry;
        System.Assert(objleaseEntry!=NULL);
        
        Glxy_ConsumerPriceIndex__c objCPI = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objleaseEntry.id,
            ProcessedDate__c = Datetime.Now().Date(),
            Acceptance620Date__c = Datetime.Now().Date(),
            FY_Obligation__c = 0,
            FY_Obligation_IA__c = 0,
            FY_Obligation_NOA__c = 0
        );
        insert objCPI;
        System.AssertNotEquals(objCPI,NULL);
        
        Glxy_ConsumerPriceIndex__c objCPI2 = new Glxy_ConsumerPriceIndex__c (
            LeaseNumber__c = objleaseEntry.id,
            ProcessedDate__c = Datetime.Now().Date().addYears(+1),
            Acceptance620Date__c = Datetime.Now().Date().addYears(+1),
            FY_Obligation__c = 0,
            FY_Obligation_NOA__c = 0,
            FY_Obligation_IA__c = 0
        );
        insert objCPI2;
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
 
        Test.startTest();     
        GLXY_BC_LoadCPI objTest = new GLXY_BC_LoadCPI();
        Database.executeBatch(objTest);      
        Test.stopTest(); 
    }
    
    static testMethod void testGLXY_BC_LoadDoubleRent(){
        Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
            StatusCode__c = 'Active',
            BaseLeaseEffectiveDate__c = Datetime.Now().Date(),
            ExpirationDateofLease__c = Datetime.Now().Date().addYears(10),
            IAConverstionDate__c = Datetime.Now().Date().addYears(5),
            RegionCD__c = '11',
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            name = 'TESTLEASE',
            BaseAnnualRent__c = 2222);
        insert objleaseEntry;
        System.Assert(objleaseEntry!=NULL);
        
        Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c();
        objPro.Name = '123456789';
        objPro.EffectiveDate__c = Datetime.Now().Date();
        objPro.AnnualRent__c = 1000.0;
        objPro.RegionCd__c = '1';
        objPro.ProjectStatus__c = 'Active';
        objPro.Old_Annual_Rent__c = 1000.0;
        objPro.Project_Type__c = 'New/Replacing';
        insert objPro;
        System.Assert(objPro!=NULL);
        
        Glxy_AssociatedLeases__c objTest = new Glxy_AssociatedLeases__c(
           Lease__c = objleaseEntry.id,  
           project__c = objPro.id,     
           Lease_Annual_Rent__c = 122     
        );
        insert objTest;
        System.Assert(objTest!=NULL);    
        
        Glxy_DoubleRent__c objTestDR = new Glxy_DoubleRent__c(
           Associated_Leases_Projects_ID__c = objTest.id,  
           Fiscal_Year__c = '2014'         
        );
        insert objTestDR;
        System.Assert(objTestDR!=NULL);              
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
        
        Test.startTest();     
        GLXY_BC_LoadDoubleRent objTestRun = new GLXY_BC_LoadDoubleRent();
        Database.executeBatch(objTestRun);      
        Test.stopTest();
    }
    
    static testMethod void testGLXY_BC_LoadIBAA(){
        Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
            StatusCode__c='Active',
            BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
            ExpirationDateofLease__c=Datetime.Now().Date().addYears(10),
            IAConverstionDate__c=Datetime.Now().Date().addYears(5),
            RegionCD__c='11',
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            name='testte',
            BaseAnnualRent__c = 2222);
        insert objleaseEntry;
        System.Assert(objleaseEntry!=NULL);
        
        Glxy_IntraBudgetActivityAuthorization__c objIBAA = new Glxy_IntraBudgetActivityAuthorization__c (
                LeaseNumber__c = objleaseEntry.id,
                AuthorizedAmount__c = 10,
                EffectiveDate__c = Datetime.Now().Date(),
                ProcessedDate__c = Datetime.Now().Date()
        );
        insert objIBAA;
        System.AssertNotEquals(objIBAA,NULL);
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
            
        Test.startTest();     
        GLXY_BC_LoadIBAA objTest = new GLXY_BC_LoadIBAA();
        Database.executeBatch(objTest);      
        Test.stopTest();  
    }
    
    static testMethod void testGLXY_BC_LoadLease(){
        Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
            StatusCode__c='Active',
            BaseLeaseEffectiveDate__c = Datetime.Now().Date().addYears(-5),
            ExpirationDateofLease__c = Datetime.Now().Date().addYears(+5),
            IAConverstionDate__c = Datetime.Now().Date().addYears(+2),
            RegionCD__c = '11',
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            name='testte',
            BaseAnnualRent__c = 2222);
        insert objleaseEntry;
        System.Assert(objleaseEntry!=NULL);
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 0, DataToStoreforXFYs__c = 10);
        
        Test.startTest();     
        GLXY_BC_LoadLease objTest = new GLXY_BC_LoadLease();
        Database.executeBatch(objTest);      
        Test.stopTest();     
    }
    
    static testMethod void testGLXY_BC_LoadLumpSum(){
        Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
            StatusCode__c='Active',
            BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
            ExpirationDateofLease__c=Datetime.Now().Date().addYears(10),
            IAConverstionDate__c=Datetime.Now().Date().addYears(5),
            RegionCD__c='11',
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            name='testte',
            Next_FY_Leases__c = False,
            BaseAnnualRent__c = 2222);
        insert objleaseEntry;
        System.Assert(objleaseEntry!=NULL);
        
        Glxy_LumpSum__c objLS = new Glxy_LumpSum__c (
                LeaseNumber__c = objleaseEntry.id,
                FY_Obligation__c = 0,
                EffectiveDate__c = Datetime.Now().Date(),
                ExpirationDate__c = Datetime.Now().Date().addYears(2),
                Acceptance620Date__c = Datetime.Now().Date(),
                BDGFlag__c = true
        );
        insert objLS;
        System.AssertNotEquals(objLS,NULL);
        
        Glxy_LumpSumObligations__c objLSO = new Glxy_LumpSumObligations__c (
                LumpSum__c = objLS.id,
                FiscalYear__c = '2014',
                FYAndLSId__c = '2014qqqqqqq'
        );
        insert objLSO;
        System.AssertNotEquals(objLSO,NULL);
        
        Glxy_LumpSumObligations__c objLSO2 = new Glxy_LumpSumObligations__c (
                LumpSum__c = objLS.id,
                FiscalYear__c = '2018',
                FYAndLSId__c = '2018qqqqqqq'
        );
        insert objLSO2;
        System.AssertNotEquals(objLSO2,NULL);
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
            
        Test.startTest();     
        GLXY_BC_LoadLumpSum objTest = new GLXY_BC_LoadLumpSum();
        Database.executeBatch(objTest);      
        Test.stopTest();    
    }
    
    static testMethod void testGLXY_BC_LoadProject(){
        List<Glxy_LeaseProjects__c> objLeaseProjectsRecords = New List<Glxy_LeaseProjects__c>();
        
        Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
            StatusCode__c='Active',
            BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
            ExpirationDateofLease__c=Datetime.Now().Date().addYears(10),
            IAConverstionDate__c=Datetime.Now().Date(),
            RegionCD__c='1',
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            name='testte',
            Next_FY_Leases__c = False,
            BaseAnnualRent__c = 2222);
        insert objleaseEntry;
        System.Assert(objleaseEntry!=NULL);
         
        Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c();
        objPro.Name='123456789';
        objPro.EffectiveDate__c = Datetime.Now().Date();
        objPro.AnnualRent__c = 1000.0;
        objPro.RegionCd__c = '1';
        objPro.ProjectStatus__c = 'Active';
        objPro.NewLease__c   = 'testte';
        objPro.eEorA__c = 'Estimate';
        objPro.Old_Annual_Rent__c = 1000.0;
        objPro.IAConversionDate__c = Datetime.Now().Date().addYears(2);
        objLeaseProjectsRecords.add(objPro);
        System.Assert(objPro != NULL);
        
        Glxy_LeaseProjects__c objPro1 = new Glxy_LeaseProjects__c();
        objPro1.Name='12345678910';
        objPro1.EffectiveDate__c = Datetime.Now().Date().addYears(1);
        objPro1.AnnualRent__c = 1000.0;
        objPro1.RegionCd__c = '1';
        objPro1.ProjectStatus__c = 'Active';
        objPro1.eEorA__c = 'Estimate';
        objPro1.Old_Annual_Rent__c = 1000.0;
        objPro1.IAConversionDate__c = Datetime.Now().Date();
        objLeaseProjectsRecords.add(objPro1);
        System.Assert(objPro1 != NULL);
        
        Glxy_LeaseProjects__c objPro2 = new Glxy_LeaseProjects__c();
        objPro2.Name = '1234569';
        objPro2.EffectiveDate__c = Datetime.Now().Date();
        objPro2.AnnualRent__c = 1000.0;
        objPro2.RegionCd__c = '1';
        objPro2.ProjectStatus__c = 'Active';
        objPro2.eEorA__c = 'Estimate';
        objPro2.Old_Annual_Rent__c = 1000.0;
        objPro2.IAConversionDate__c = Datetime.Now().Date();
        objLeaseProjectsRecords.add(objPro2);
        System.Assert(objPro2 != NULL);

        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
        
        Insert objLeaseProjectsRecords;
        
        Test.startTest();     
        GLXY_BC_LoadProject objTest2 = new GLXY_BC_LoadProject();
        Database.executeBatch(objTest2);      
        Test.stopTest();
    }
    
    static testMethod void testGLXY_BC_LoadProjectLumpSum(){
        Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c();
        objPro.Name='123456789';
        Date myDate = Datetime.Now().Date();
        objPro.EffectiveDate__c=myDate;
        objPro.AnnualRent__c=1000.0;
        objPro.RegionCd__c='1';
        objPro.ProjectStatus__c='Active';
        objPro.Old_Annual_Rent__c=1000.0;
        insert objPro;
        System.Assert(objPro!=NULL);
        
        Glxy_LPLumpSum__c objTest = new Glxy_LPLumpSum__c();
        objTest.ProjectNumber__c = objPro.id;
        objTest.EffectiveDate__c = myDate;
        objTest.ExpirationDate__c = myDate;
        insert objTest;
        System.Assert(objTest!=NULL);
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
                    
        Test.startTest();     
        GLXY_BC_LoadProjectLumpSum objTest2 = new GLXY_BC_LoadProjectLumpSum();
        Database.executeBatch(objTest2);      
        Test.stopTest();
    }
    
    static testMethod void testGLXY_BC_LoadProjectStepRent(){
        Glxy_LeaseProjects__c objPro = new Glxy_LeaseProjects__c();
        objPro.Name='123456789';
        Date myDate = date.newinstance(2012, 2, 17);
        objPro.EffectiveDate__c=myDate;
        objPro.AnnualRent__c=1000.0;
        objPro.RegionCd__c='1';
        objPro.ProjectStatus__c='Active';
        objPro.Old_Annual_Rent__c=1000.0;
        insert objPro;
        System.Assert(objPro!=NULL);
        
        Glxy_LPStepRent__c objTest = new Glxy_LPStepRent__c (
            ProjectNumber__c = objPro.id,
            EffectiveDate__c = myDate,
            PaymentType__c = 'Antenna',
            Amount__c = 99,
            StatusCode__c = 'Estimate'                             
        );
        insert objTest;
        System.Assert(objTest!=NULL);
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
                    
        Test.startTest();     
        GLXY_BC_LoadProjectStepRent objTest2 = new GLXY_BC_LoadProjectStepRent();
        Database.executeBatch(objTest2);      
        Test.stopTest(); 
    }
    
    static testMethod void testGLXY_BC_LoadRWA(){
        Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
            StatusCode__c='Active',
            BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
            ExpirationDateofLease__c=Datetime.Now().Date().addYears(10),
            IAConverstionDate__c=Datetime.Now().Date().addYears(5),
            RegionCD__c='11',
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            name='testte',
            BaseAnnualRent__c = 2222);
        insert objleaseEntry;
        System.Assert(objleaseEntry!=NULL);
        
        Glxy_ReimbursableWorkAuthorization__c objRWA = new Glxy_ReimbursableWorkAuthorization__c (
                LeaseNumber__c = objleaseEntry.id,
                Amount__c = 10,
                EffectiveDate__c = Datetime.Now().Date(),
                ProcessedDate__c = Datetime.Now().Date()
        );
        insert objRWA;
        System.AssertNotEquals(objRWA,NULL);
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
            
        Test.startTest();     
        GLXY_BC_LoadRWA objTest = new GLXY_BC_LoadRWA();
        Database.executeBatch(objTest);      
        Test.stopTest(); 
    }
    
    static testMethod void testGLXY_BC_LoadStepRent(){
        Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
            StatusCode__c='Active',
            BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
            ExpirationDateofLease__c=Datetime.Now().Date().addYears(10),
            IAConverstionDate__c=Datetime.Now().Date().addYears(2),
            RegionCD__c='11',
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            Next_FY_Leases__c = False,
            name='testte',
            BaseAnnualRent__c = 2222);
        insert objleaseEntry;
        System.Assert(objleaseEntry!=NULL);
        
        Glxy_StepRent__c objStepRent = new Glxy_StepRent__c (
                LeaseNumber__c = objleaseEntry.id,
                ProcessedDate__c = Datetime.Now().Date(),
                EffectiveDate__c = Datetime.Now().Date(),
                Acceptance620Date__c = Datetime.Now().Date(),
                Amount__c = 100
        );
        insert objStepRent;
        System.AssertNotEquals(objStepRent,NULL);
        
        Glxy_Lease__c objleaseEntry2 = new Glxy_Lease__c(
            StatusCode__c = 'Active',
            BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
            ExpirationDateofLease__c=Datetime.Now().Date().addYears(10),
            IAConverstionDate__c=Datetime.Now().Date(),
            RegionCD__c='11',
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            Next_FY_Leases__c = False,
            name='testtv',
            BaseAnnualRent__c = 2222);
        insert objleaseEntry2;
        System.Assert(objleaseEntry2!=NULL);
        
        Glxy_StepRent__c objStepRent2 = new Glxy_StepRent__c (
                LeaseNumber__c = objleaseEntry2.id,
                ProcessedDate__c = Datetime.Now().Date(),
                EffectiveDate__c = Datetime.Now().Date(),
                Acceptance620Date__c = Datetime.Now().Date(),
                Amount__c = 100
        );
        insert objStepRent2;
        System.AssertNotEquals(objStepRent2,NULL);
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
            
        Test.startTest();     
        GLXY_BC_LoadStepRent objTest = new GLXY_BC_LoadStepRent();
        Database.executeBatch(objTest);      
        Test.stopTest();   
    }
    
    static testMethod void testGLXY_BC_LoadTaxes(){
        Glxy_Lease__c objleaseEntry = new Glxy_Lease__c(
            StatusCode__c='Active',
            BaseLeaseEffectiveDate__c=Datetime.Now().Date(),
            ExpirationDateofLease__c=Datetime.Now().Date().addYears(10),
            IAConverstionDate__c=Datetime.Now().Date().addYears(5),
            RegionCD__c='11',
            Total_NOA_Sq_feet__c = 0,
            Total_IA_Sq_feet__c = 0,
            name='testte',
            Next_FY_Leases__c = False,
            BaseAnnualRent__c = 2222);
        insert objleaseEntry;
        System.Assert(objleaseEntry!=NULL);
        
        Glxy_LumpSum__c objLS = new Glxy_LumpSum__c (
            LeaseNumber__c = objleaseEntry.id,
            LumSumType__c = 'Tax Escalation',
            FY_Obligation__c = 0,
            EffectiveDate__c = Datetime.Now().Date(),
            ExpirationDate__c = Datetime.Now().Date().addYears(2),
            Acceptance620Date__c = Datetime.Now().Date(),
            BDGFlag__c = true
        );
        insert objLS;
        System.AssertNotEquals(objLS,NULL);
        
        Glxy_LumpSumObligations__c objLSO = new Glxy_LumpSumObligations__c (
            LumpSum__c = objLS.id,
            FiscalYear__c = '2014',
            FYAndLSId__c = '2014qqqqqqq'
        );
        insert objLSO;
        System.AssertNotEquals(objLSO,NULL);
        
        Glxy_LumpSumObligations__c objLSO2 = new Glxy_LumpSumObligations__c (
            LumpSum__c = objLS.id,
            FiscalYear__c = '2018',
            FYAndLSId__c = '2018qqqqqqq'
        );
        insert objLSO2;
        System.AssertNotEquals(objLSO2,NULL);
        
        Insert new GalaxyBudgetCall__c(Name='TEST', AdjustFiscalYear__c = 1, DataToStoreforXFYs__c = 3);
            
        Test.startTest();     
        GLXY_BC_LoadTaxes objTest = new GLXY_BC_LoadTaxes();
        Database.executeBatch(objTest);      
        Test.stopTest();
    }
    
    @isTest (SeeAllData=false) static void testGLXY_BC_ComputeLeaseTotals(){
        
        integer intFiscalYear = (Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year());
        string  strFiscalYear = String.ValueOf(intFiscalYear);
        List<Glxy_BudgetCallLineItem__c> objBCRecords = New List<Glxy_BudgetCallLineItem__c>();
        
        Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry); 
        
        Glxy_BudgetCallLineItem__c objBCEntry2 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry2); 
        
        Glxy_BudgetCallLineItem__c objBCEntry3 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Operating Cost Escalation (CPI)',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry3); 
        
        Glxy_BudgetCallLineItem__c objBCEntry4 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Taxes',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry4); 
        
        Glxy_BudgetCallLineItem__c objBCEntry5 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry5); 
        
        Glxy_BudgetCallLineItem__c objBCEntry6 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'IBAA',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry6); 
        
        Glxy_BudgetCallLineItem__c objBCEntry7 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'RWA',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry7); 
        
        Glxy_BudgetCallLineItem__c objBCEntry8 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Double Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry8); 
        
        Glxy_BudgetCallLineItem__c objBCEntry9 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry9); 
        
        Glxy_BudgetCallLineItem__c objBCEntry10 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry10); 
        
        Glxy_BudgetCallLineItem__c objBCEntry11 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry11);
        
        Glxy_BudgetCallLineItem__c objBCEntry12 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry12); 
        
        Glxy_BudgetCallLineItem__c objBCEntry13 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry13); 
        
        Glxy_BudgetCallLineItem__c objBCEntry14 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Operating Cost Escalation (CPI)',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry14); 
        
        Glxy_BudgetCallLineItem__c objBCEntry15 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Taxes',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry15); 
        
        Glxy_BudgetCallLineItem__c objBCEntry16 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry16); 
        
        Glxy_BudgetCallLineItem__c objBCEntry17 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'IBAA',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry17); 
        
        Glxy_BudgetCallLineItem__c objBCEntry18 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'RWA',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry18); 
        
        Glxy_BudgetCallLineItem__c objBCEntry19 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Double Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry19); 
        
        Glxy_BudgetCallLineItem__c objBCEntry20 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry20); 
        
        Glxy_BudgetCallLineItem__c objBCEntry21 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry21); 
        
        Glxy_BudgetCallLineItem__c objBCEntry22 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry22);
        
        insert objBCRecords;
        System.Assert(objBCRecords!=NULL);
        
        //Test.startTest();     
        GLXY_BC_ComputeLeaseTotals objTest = new GLXY_BC_ComputeLeaseTotals();
        Database.executeBatch(objTest);   
        GLXY_BC_ComputeLeaseTotalsa objTest1 = new GLXY_BC_ComputeLeaseTotalsa();
        Database.executeBatch(objTest1);    
        //Test.stopTest();     
    } 
    
    @isTest (SeeAllData=false) static void testGLXY_BC_ComputeLeaseTotals2(){
        
        integer intFiscalYear = (Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year());
        intFiscalYear += 1;
        string  strFiscalYear = String.ValueOf(intFiscalYear);
        List<Glxy_BudgetCallLineItem__c> objBCRecords = New List<Glxy_BudgetCallLineItem__c>();
        
        Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry); 
        
        Glxy_BudgetCallLineItem__c objBCEntry2 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry2); 
        
        Glxy_BudgetCallLineItem__c objBCEntry3 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Operating Cost Escalation (CPI)',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry3); 
        
        Glxy_BudgetCallLineItem__c objBCEntry4 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Taxes',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry4); 
        
        Glxy_BudgetCallLineItem__c objBCEntry5 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry5); 
        
        Glxy_BudgetCallLineItem__c objBCEntry6 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'IBAA',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry6); 
        
        Glxy_BudgetCallLineItem__c objBCEntry7 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'RWA',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry7); 
        
        Glxy_BudgetCallLineItem__c objBCEntry8 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Double Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry8); 
        
        Glxy_BudgetCallLineItem__c objBCEntry9 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry9); 
        
        Glxy_BudgetCallLineItem__c objBCEntry10 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry10); 
        
        Glxy_BudgetCallLineItem__c objBCEntry11 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry11);
        
        Glxy_BudgetCallLineItem__c objBCEntry12 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry12); 
        
        Glxy_BudgetCallLineItem__c objBCEntry13 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry13); 
        
        Glxy_BudgetCallLineItem__c objBCEntry14 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Operating Cost Escalation (CPI)',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry14); 
        
        Glxy_BudgetCallLineItem__c objBCEntry15 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Taxes',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry15); 
        
        Glxy_BudgetCallLineItem__c objBCEntry16 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry16); 
        
        Glxy_BudgetCallLineItem__c objBCEntry17 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'IBAA',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry17); 
        
        Glxy_BudgetCallLineItem__c objBCEntry18 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'RWA',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry18); 
        
        Glxy_BudgetCallLineItem__c objBCEntry19 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Double Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry19); 
        
        Glxy_BudgetCallLineItem__c objBCEntry20 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry20); 
        
        Glxy_BudgetCallLineItem__c objBCEntry21 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry21); 
        
        Glxy_BudgetCallLineItem__c objBCEntry22 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry22);
        
        insert objBCRecords;
        System.Assert(objBCRecords!=NULL);
        
        //Test.startTest();     
        GLXY_BC_ComputeLeaseTotals2 objTest = new GLXY_BC_ComputeLeaseTotals2();
        Database.executeBatch(objTest);     
        GLXY_BC_ComputeLeaseTotals2a objTest1 = new GLXY_BC_ComputeLeaseTotals2a();
        Database.executeBatch(objTest1);   
        //Test.stopTest();     
    } 
    
    @isTest (SeeAllData=false) static void testGLXY_BC_ComputeLeaseTotals3(){
        
        integer intFiscalYear = (Datetime.Now().Date().Month() > 9? Datetime.Now().Date().Year() + 1 : Datetime.Now().Date().Year());
        intFiscalYear += 2;
        string  strFiscalYear = String.ValueOf(intFiscalYear);
        List<Glxy_BudgetCallLineItem__c> objBCRecords = New List<Glxy_BudgetCallLineItem__c>();
        
        Glxy_BudgetCallLineItem__c objBCEntry = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry); 
        
        Glxy_BudgetCallLineItem__c objBCEntry2 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry2); 
        
        Glxy_BudgetCallLineItem__c objBCEntry3 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Operating Cost Escalation (CPI)',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry3); 
        
        Glxy_BudgetCallLineItem__c objBCEntry4 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Taxes',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry4); 
        
        Glxy_BudgetCallLineItem__c objBCEntry5 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry5); 
        
        Glxy_BudgetCallLineItem__c objBCEntry6 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'IBAA',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry6); 
        
        Glxy_BudgetCallLineItem__c objBCEntry7 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'RWA',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry7); 
        
        Glxy_BudgetCallLineItem__c objBCEntry8 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Double Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry8); 
        
        Glxy_BudgetCallLineItem__c objBCEntry9 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry9); 
        
        Glxy_BudgetCallLineItem__c objBCEntry10 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry10); 
        
        Glxy_BudgetCallLineItem__c objBCEntry11 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '2');
        objBCRecords.add(objBCEntry11);
        
        Glxy_BudgetCallLineItem__c objBCEntry12 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear);
        objBCRecords.add(objBCEntry12); 
        
        Glxy_BudgetCallLineItem__c objBCEntry13 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry13); 
        
        Glxy_BudgetCallLineItem__c objBCEntry14 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Operating Cost Escalation (CPI)',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry14); 
        
        Glxy_BudgetCallLineItem__c objBCEntry15 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Taxes',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry15); 
        
        Glxy_BudgetCallLineItem__c objBCEntry16 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry16); 
        
        Glxy_BudgetCallLineItem__c objBCEntry17 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'IBAA',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry17); 
        
        Glxy_BudgetCallLineItem__c objBCEntry18 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'RWA',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry18); 
        
        Glxy_BudgetCallLineItem__c objBCEntry19 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00374',
            BudgetCategory__c = 'Double Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry19); 
        
        Glxy_BudgetCallLineItem__c objBCEntry20 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Base Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry20); 
        
        Glxy_BudgetCallLineItem__c objBCEntry21 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Lump Sums',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry21); 
        
        Glxy_BudgetCallLineItem__c objBCEntry22 = new Glxy_BudgetCallLineItem__c(
            LeaseNumber__c = 'LDE00372',
            BudgetCategory__c = 'Project Step Rent',
            FiscalYear__c = strFiscalYear,
            RegionCode__c = '8');
        objBCRecords.add(objBCEntry22);
        
        insert objBCRecords;
        System.Assert(objBCRecords!=NULL);
        
        //Test.startTest();     
        GLXY_BC_ComputeLeaseTotals3 objTest = new GLXY_BC_ComputeLeaseTotals3();
        Database.executeBatch(objTest); 
        GLXY_BC_ComputeLeaseTotals3a objTest1 = new GLXY_BC_ComputeLeaseTotals3a();
        Database.executeBatch(objTest1);      
        //Test.stopTest();     
    } 
  
}