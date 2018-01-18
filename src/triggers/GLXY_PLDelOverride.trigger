trigger GLXY_PLDelOverride on Glxy_ProjectLocation__c (before delete) {

List<string> profileNamelist= new list<string>();
profileNamelist.add('GSA System Administrator');
profileNamelist.add('System Administrator');
Map<id,Profile> adminProfileMap = new Map<id,Profile>([select id ,name from profile where name in :profileNamelist]);
string adminUser= [select id from user where name='CastIron User'].id;
system.debug(adminUser);
system.debug(adminProfileMap);
string RexusRecordType=Schema.SObjectType.Glxy_ProjectLocation__c.getRecordTypeInfosByName().get('Rexus').getRecordTypeId();
system.debug(RexusRecordType);
for(Glxy_ProjectLocation__c pi:trigger.old )
{
  
 if(pi.RecordTypeid==RexusRecordType)
 {
 
  if(userinfo.getuserId()==adminUser || adminProfileMap.get(userinfo.getprofileId())!=null)
  {
   continue;
  
  }
   pi.addError('This is a REXUS Record, You do not have Delete Privileges to it.');
  
 
  }
}

}