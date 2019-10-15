@isTest
private class ProjectCalloutServiceTest {
    
    //Implement mock callout tests here
    @testSetup static void testSetupdata(){
		//create the opportunity record
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'Test Opportunity First';
        opp1.Type = 'New Project';
        opp1.Amount = 1000;
        opp1.CloseDate = Date.today();
        opp1.StageName = 'Submitted Project';
        insert opp1;
		//create the opportunity record
        Opportunity opp2 = new Opportunity();
        opp2.Name = 'Test Opportunity';
        opp2.Type = 'New Project';
        opp2.Amount = 1000;
        opp2.CloseDate = Date.today();
        opp2.StageName = 'Resubmit Project';
        insert opp2;
        //create the Custom Settings
        ServiceTokens__c servToken = new ServiceTokens__c();
        servToken.Name = 'ProjectServiceToken';
        servToken.Token__c = 'shgglskgblsbglbdsflgbldmfbgldb';
        insert servToken;
    }
    
    //Possitive Test
    @isTest static void testPostCalloutSuccess() {
        Opportunity oppor = [Select Id, Name FROM Opportunity WHERE Name = 'Test Opportunity First' Limit 1];
        List<Id> oppList = new List<Id>();
        oppList.add(oppor.Id);
        System.assertEquals('Test Opportunity First', oppor.Name);
        System.assertEquals(1,oppList.size());
        Test.startTest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        ProjectCalloutService.postOpportunityToPMS(oppList);
        // Verify that the response received contains fake values
        Test.stopTest();    
        oppor = [select StageName from Opportunity where id =: oppor.Id];
        System.assertEquals('Submitted Project',oppor.StageName);
    }
    
    //Negative Test
    @isTest static void testPostCalloutFailure() {
        Opportunity oppor = [Select Id, Name FROM Opportunity WHERE Name = 'Test Opportunity' Limit 1];
        List<Id> oppList = new List<Id>();
        oppList.add(oppor.Id);
        System.assertEquals('Test Opportunity', oppor.Name);
        System.assertEquals(1,oppList.size());
        Test.startTest();
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        ProjectCalloutService.postOpportunityToPMS(oppList);
        // Verify that the response received contains fake values
        Test.stopTest();        
        oppor = [select StageName from Opportunity where id =: oppor.Id];
        System.assertEquals('Resubmit Project',oppor.StageName);
    }
    
    
}