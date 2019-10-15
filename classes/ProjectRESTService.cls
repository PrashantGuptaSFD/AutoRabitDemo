@RestResource(urlMapping = '/Project/*')
global class ProjectRESTService {

    @HttpPost
    global static string postProjectData(String ProjectRef, String ProjectName, String OpportunityId, Date StartDate, Date EndDate, Double Amount, String Status) {
        Savepoint sp = Database.setSavepoint();
        try {
            List < Project__c > ProjectToUpsert = new List < Project__c > ();
            List < Opportunity > OppToUpdate = new List < Opportunity > ();
            if (OpportunityId != null) {
                for (Opportunity opp: [SELECT id, DeliveryInstallationStatus__c from Opportunity where id =: Id.ValueOf(OpportunityId)]) {
                    Project__c pro = new Project__c();
                    pro.Name = ProjectName;
                    pro.Billable_Amount__c = Amount;
                    pro.End_Date__c = EndDate;
                    pro.Opportunity__c = OpportunityId;
                    pro.ProjectRef__c = ProjectRef;
                    pro.Start_Date__c = StartDate;
                    pro.Status__c = Status;
                    ProjectToUpsert.add(pro);
                    opp.DeliveryInstallationStatus__c = 'In Progress';
                    OppToUpdate.add(opp);
                }
            }
            If(ProjectToUpsert.size() > 0)
            upsert ProjectToUpsert ProjectRef__c;
            if (OppToUpdate.size() > 0)
                update OppToUpdate;
            return 'OK';
        } catch (exception ex) {
            Database.rollback(sp);
            return 'Failed';
        }

    }
}