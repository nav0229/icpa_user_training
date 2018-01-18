global with sharing class CollaborationGroupController {

    public String groupType { get; set;}
    public String groupName { get;set;}
    public List<SelectOption> selectGroups {get;set;} 
    public List<SelectOption> selectTypes {get;set;}
    
    public PageReference groupHealthCheck() {
        return  null;
    }

    public List<SelectOption> getCollaborationGroups() 
    {
        List<SelectOption> options = new List<SelectOption>();
        List<CollaborationGroup> chatterGroupList = [Select c.Id,c.Name From CollaborationGroup c where c.CollaborationType = :groupType order by c.Name ASC limit 999]; 
        for(CollaborationGroup chatterGroup : chatterGroupList)
        {
            options.add(new SelectOption(chatterGroup.Name,chatterGroup.Name)); 
        }
        return options;
    }    
    
    public PageReference  getLoadCollaborationGroups() 
    {
        List<SelectOption> options = new List<SelectOption>();
        List<CollaborationGroup> chatterGroupList = [Select c.Id,c.Name From CollaborationGroup c where c.CollaborationType = :groupType order by c.Name ASC limit 999]; 
        for(CollaborationGroup chatterGroup : chatterGroupList)
        {
            options.add(new SelectOption(chatterGroup.Name,chatterGroup.Name));
        }
        selectGroups = options; 
        return null;
    }    
    
    
    public List<SelectOption> getCollaborationGroupType() 
    {
        List<SelectOption> options = new List<SelectOption>();
        List<AggregateResult> chatterGroupTypeList = [Select CollaborationType From CollaborationGroup Group By  CollaborationType order by  CollaborationType  DESC LIMIT 100]; 

        for(AggregateResult ar : chatterGroupTypeList)
        {
            options.add(new SelectOption((String)ar.get('CollaborationType'),(String)ar.get('CollaborationType')));
        }
        selectTypes = options;
        return options;
    }    
    

    @RemoteAction   
    global static ChartRecord[] getGroupHealthCheck(String selectedGroupId,String selectedGroupType) {
            date todayDate = date.today();
            //string year = todayDate.year()+'';
            //string month = (todayDate.month() - 6)+'';
            //string stringDate = year + '-' + month + '-' + 1 ;
            //Date sixMonthsBeforeDate = date.valueOf(stringDate);
            Date sixMonthsBeforeDate = date.today().addMonths(-6);            
            List<ChartRecord> chartRecords = new List<ChartRecord>();
            
            //List<CollaborationGroupMember> collaborationGroupMembers = [Select c.CreatedDate,c.CollaborationGroup.MemberCount From CollaborationGroupMember c where c.CollaborationGroup.Name = :selectedGroupId and c.CollaborationGroup.CollaborationType = :selectedGroupType and c.CreatedDate > :sixMonthsBeforeDate order by c.CreatedDate];
            List<AggregateResult> chatterGroupMemberCountByMonth = [SELECT CALENDAR_MONTH(c.CreatedDate) month ,count(c.Id) memberCount From CollaborationGroupMember c where c.CollaborationGroup.Name = :selectedGroupId and c.CollaborationGroup.CollaborationType = :selectedGroupType and CALENDAR_YEAR(c.CreatedDate) = :todayDate.year() group by CALENDAR_MONTH(c.CreatedDate) LIMIT 100]; 
            Map<Integer,Integer> chatterGroupMemberCountByMonthMap = new Map<Integer,Integer>();
            for(AggregateResult ar : chatterGroupMemberCountByMonth)
            {
              chatterGroupMemberCountByMonthMap.put(Integer.valueOf(ar.get('month')),Integer.valueOf(ar.get('memberCount')));
            }

            List<AggregateResult> chatterGroupFeedCountByMonth = [select CALENDAR_MONTH(c.CreatedDate) month ,count(c.Id) feedCount  From CollaborationGroupFeed c where c.Parent.Name = :selectedGroupId and CALENDAR_YEAR(c.CreatedDate) = :todayDate.year() group by CALENDAR_MONTH(c.CreatedDate) LIMIT 100]; 
            Map<Integer,Integer> chatterGroupFeedCountByMonthMap = new Map<Integer,Integer>();

            if(chatterGroupFeedCountByMonth != null && chatterGroupFeedCountByMonth.size() > 0)
            {
                for(AggregateResult ar : chatterGroupFeedCountByMonth)
                {
                  chatterGroupFeedCountByMonthMap.put(Integer.valueOf(ar.get('month')),Integer.valueOf(ar.get('feedCount'))); 
                }
            }    
            Integer groupMemberCount = 0;
            LIST<CollaborationGroup> collaborationGroups = [Select c.MemberCount  From CollaborationGroup c where c.Name =  :selectedGroupId  and c.CollaborationType = :selectedGroupType Limit 1];
            if(collaborationGroups != null && collaborationGroups.size() > 0)
            {
                groupMemberCount = collaborationGroups.get(0).MemberCount;
            }

            
            Integer monthlyMemberCount = groupMemberCount;
            LIST<CollaborationGroupFeed> collaborationGroupFeeds= [Select (Select Id, FeedItemId, CreatedDate, CommentBody From FeedComments where CALENDAR_YEAR(CreatedDate) = :todayDate.year()) From CollaborationGroupFeed c where c.Parent.Name = :selectedGroupId and c.Parent.CollaborationType = :selectedGroupType Limit 10000];
            Map<Integer,LIST<FeedComment>> feedComments = new Map<Integer,LIST<FeedComment>>();
            if(collaborationGroupFeeds != null && collaborationGroupFeeds.size() > 0)
            {
                for(CollaborationGroupFeed groupFeed : collaborationGroupFeeds)
                {
                    for(FeedComment feedComment: groupFeed.FeedComments)
                    {
                        if(feedComments.containsKey(feedComment.CreatedDate.month()))
                        {
                            LIST<FeedComment> listFeedComments = feedComments.get(feedComment.CreatedDate.month());
                            listFeedComments.add(feedComment);
                            feedComments.put(feedComment.CreatedDate.month(),listFeedComments);
                        }
                        else
                        {
                             LIST<FeedComment> listFeedComments = new LIST<FeedComment>();
                             listFeedComments.add(feedComment);
                             feedComments.put(feedComment.CreatedDate.month(),listFeedComments);
                        }
                    }
                }
            }
             
            Integer groupTotalCommentCount = 0;
            //Grouping the Comment Count by month
            if(feedComments != null && feedComments.size() > 0)
                groupTotalCommentCount = feedComments.size();
                
                
            //Last Three NOT completed.
            //Integer likesCount = 0;
            //////////////*****************
            List<AggregateResult> chatterGroupFeedLikesCountByMonth = [select CALENDAR_MONTH(c.CreatedDate) month ,SUM(LIKECOUNT) like1Count From CollaborationGroupFeed c where c.Parent.Name = :selectedGroupId and CALENDAR_YEAR(c.CreatedDate) = :todayDate.year() group by CALENDAR_MONTH(c.CreatedDate) LIMIT 100]; 
            Map<Integer,Integer> chatterGroupFeedLikesCountByMonthMap = new Map<Integer,Integer>();

            if(chatterGroupFeedLikesCountByMonth  != null && chatterGroupFeedLikesCountByMonth.size() > 0)
            {
                for(AggregateResult ar : chatterGroupFeedLikesCountByMonth)
                {
                  chatterGroupFeedLikesCountByMonthMap.put(Integer.valueOf(ar.get('month')),Integer.valueOf(ar.get('like1Count'))); 
                }
            }              
            
            //LinkPost
            List<AggregateResult> chatterGroupFeedLinksCountByMonth = [select CALENDAR_MONTH(c.CreatedDate) month ,count(c.Id) linkCount From CollaborationGroupFeed c where c.Parent.Name = :selectedGroupId and CALENDAR_YEAR(c.CreatedDate) = :todayDate.year() and c.Type = 'LinkPost' group by CALENDAR_MONTH(c.CreatedDate) LIMIT 100]; 
            Map<Integer,Integer> chatterGroupFeedLinksCountByMonthMap = new Map<Integer,Integer>();

            if(chatterGroupFeedLinksCountByMonth != null && chatterGroupFeedLinksCountByMonth.size() > 0)
            {
                for(AggregateResult ar : chatterGroupFeedLinksCountByMonth)
                {
                  chatterGroupFeedLinksCountByMonthMap.put(Integer.valueOf(ar.get('month')),Integer.valueOf(ar.get('linkCount'))); 
                }
            }              
            
            List<AggregateResult> chatterGroupFeedDocsCountByMonth = [select CALENDAR_MONTH(c.CreatedDate) month ,count(c.Id) docCount From CollaborationGroupFeed c where c.Parent.Name = :selectedGroupId and CALENDAR_YEAR(c.CreatedDate) = :todayDate.year() and c.Type = 'ContentPost' group by CALENDAR_MONTH(c.CreatedDate) LIMIT 100]; 
            Map<Integer,Integer> chatterGroupFeedDocsCountByMonthMap = new Map<Integer,Integer>();

            if(chatterGroupFeedDocsCountByMonth != null && chatterGroupFeedDocsCountByMonth.size() > 0)
            {
                for(AggregateResult ar : chatterGroupFeedDocsCountByMonth)
                {
                  chatterGroupFeedDocsCountByMonthMap.put(Integer.valueOf(ar.get('month')),Integer.valueOf(ar.get('docCount'))); 
                }
            }              
            /*
            //Over all doc and link count
            List<AggregateResult> chatterGroupFeedLinksCountByMonth = [select count(c.Id) linkCount From CollaborationGroupFeed c where c.Parent.Name = :selectedGroupId and c.Type = 'LinkPost']; 
            Integer totalLinkCount = 0;
            if(chatterGroupFeedLinksCountByMonth != null && chatterGroupFeedLinksCountByMonth.size() > 0)
            {
                for(AggregateResult ar : chatterGroupFeedLinksCountByMonth)
                {
                  totalLinkCount = Integer.valueOf(ar.get('linkCount'));
                }
            }              
            
            List<AggregateResult> chatterGroupFeedDocsCountByMonth = [select count(c.Id) docCount From CollaborationGroupFeed c where c.Parent.Name = :selectedGroupId and c.Type = 'ContentPost']; 
            Integer totalDocCount = 0;
            if(chatterGroupFeedDocsCountByMonth != null && chatterGroupFeedDocsCountByMonth.size() > 0)
            {
                for(AggregateResult ar : chatterGroupFeedDocsCountByMonth)
                {
                  totalDocCount = Integer.valueOf(ar.get('docCount'));
                }
                
            }              
            */
            Integer totalLinkCount = 0;
            Integer totalDocCount = 0;
            Integer[] totalDocsMonths = new Integer[]{4,3,2,1,0};
            date todayForDocLinkDate = date.today();
            for (Integer j : totalDocsMonths) 
            {
                if(j != 0)
                {
                    todayForDocLinkDate = todayForDocLinkDate.addMonths(-j);
                    if(chatterGroupFeedLinksCountByMonthMap != null && chatterGroupFeedLinksCountByMonthMap.size() > 0 && chatterGroupFeedLinksCountByMonthMap.containsKey(todayForDocLinkDate.month()))
                    {
                        totalLinkCount = totalLinkCount + (Integer)chatterGroupFeedLinksCountByMonthMap.get(todayForDocLinkDate.month());
                        chatterGroupFeedLinksCountByMonthMap.put(todayForDocLinkDate.month(),totalLinkCount); 
                    }
                    if(chatterGroupFeedDocsCountByMonthMap != null && chatterGroupFeedDocsCountByMonthMap.size() > 0 && chatterGroupFeedDocsCountByMonthMap.containsKey(todayForDocLinkDate.month()))
                    {
                        totalDocCount  = totalDocCount + (Integer)chatterGroupFeedDocsCountByMonthMap.get(todayForDocLinkDate.month());                    
                        chatterGroupFeedDocsCountByMonthMap.put(todayForDocLinkDate.month(),totalDocCount);
                    }
                } 
            }
            
            
            //////////////*****************            
            
            
            Integer monthlyCommentCount = 0;
            Integer[] myInts = new Integer[]{0,1,2,3,4};
            //Integer[] myInts = new Integer[]{5,4,3,2,1};
            for (Integer i : myInts) 
            {
                if(i != 0)
                {
                    todayDate = todayDate.addMonths(-1);
                }        
                Integer memberCount = 0;
                Integer feedCount = 0;
                Integer newCommentCount = 0;
                Integer likes1Count  = 0;
                Integer linkCount = 0;
                Integer docCount = 0;        
                totalLinkCount= 0;
                totalDocCount = 0;        
                
                if(chatterGroupMemberCountByMonthMap != null && chatterGroupMemberCountByMonthMap.size() > 0 && chatterGroupMemberCountByMonthMap.containsKey(todayDate.month()))
                    memberCount = (Integer)chatterGroupMemberCountByMonthMap.get(todayDate.month());

                if(chatterGroupFeedCountByMonthMap  != null && chatterGroupFeedCountByMonthMap.size() > 0 && chatterGroupFeedCountByMonthMap.containsKey(todayDate.month()))
                    feedCount = (Integer)chatterGroupFeedCountByMonthMap.get(todayDate.month());
                    
                if(feedComments != null && feedComments.size() > 0 && feedComments.containsKey(todayDate.month()))
                {
                    LIST<FeedComment> commentsList = feedComments.get(todayDate.month());
                    newCommentCount = commentsList.size();
                    monthlyCommentCount = monthlyCommentCount + newCommentCount;
                }
                
                //Likes Count
                if(chatterGroupFeedLikesCountByMonthMap != null && chatterGroupFeedLikesCountByMonthMap.size() > 0 && chatterGroupFeedLikesCountByMonthMap.containsKey(todayDate.month()))
                    likes1Count  = (Integer)chatterGroupFeedLikesCountByMonthMap.get(todayDate.month());
                /*
                //Monthly Count    
                //Links Count
                if(chatterGroupFeedLinksCountByMonthMap != null && chatterGroupFeedLinksCountByMonthMap.size() > 0 && chatterGroupFeedLinksCountByMonthMap.containsKey(todayDate.month()))
                    linkCount = (Integer)chatterGroupFeedLinksCountByMonthMap.get(todayDate.month());
                    
                //Doc Count
                if(chatterGroupFeedDocsCountByMonthMap != null && chatterGroupFeedDocsCountByMonthMap.size() > 0 && chatterGroupFeedDocsCountByMonthMap.containsKey(todayDate.month()))
                    docCount = (Integer)chatterGroupFeedDocsCountByMonthMap.get(todayDate.month());
                
                if(chatterGroupFeedLinksCountByMonth != null && chatterGroupFeedLinksCountByMonth.size() > 0)
                {
                    linkCount = totalLinkCount;
                }
                if(chatterGroupFeedDocsCountByMonth != null && chatterGroupFeedDocsCountByMonth.size() > 0)
                {
                    docCount = totalDocCount;
                }
                */
                if(chatterGroupFeedLinksCountByMonthMap != null && chatterGroupFeedLinksCountByMonthMap.size() > 0 && chatterGroupFeedLinksCountByMonthMap.containsKey(todayDate.month()))
                    totalLinkCount = (Integer)chatterGroupFeedLinksCountByMonthMap.get(todayDate.month());
                    
                if(chatterGroupFeedDocsCountByMonthMap != null && chatterGroupFeedDocsCountByMonthMap.size() > 0 && chatterGroupFeedDocsCountByMonthMap.containsKey(todayDate.month()))
                    totalDocCount  = (Integer)chatterGroupFeedDocsCountByMonthMap.get(todayDate.month());
                    
                    
                monthlyMemberCount = monthlyMemberCount - memberCount; 
                ChartRecord chartRecord = new ChartRecord(todayDate.year() +'/' +todayDate.month(),feedCount,newCommentCount,memberCount,monthlyMemberCount,monthlyCommentCount,likes1Count,totalLinkCount,totalDocCount);
                chartRecords.add(chartRecord);
            }
            return chartRecords; 
    }       
    
    global with sharing class ChartRecord{
        public String month {get;set;}
        public Integer numberOfPosts {get;set;}
        public Integer numberOfComments {get;set;}
        public Integer numberOfLikes {get;set;}
        public Integer numberOfNewlyJoined {get;set;}
        public Integer totalMembers {get;set;}                                        
        public Integer totalComments {get;set;}                                                
        public Integer linkCount {get;set;}  
        public Integer docCount {get;set;}  

        ChartRecord(String month,Integer numberOfPosts,Integer numberOfComments,Integer numberOfNewlyJoined,Integer totalMembers,Integer totalComments,Integer numberOfLikes,Integer linkCount,Integer docCount) 
        {
            this.month = month;
            this.numberOfPosts = numberOfPosts;
            this.numberOfComments = numberOfComments;
            this.numberOfLikes = numberOfLikes;
            this.numberOfNewlyJoined = numberOfNewlyJoined;
            this.totalMembers = totalMembers;
            this.totalComments = totalComments;        
            this.numberOfLikes = numberOfLikes;
            this.linkCount= linkCount;        
            this.docCount = docCount;    
        }
    }    
    @RemoteAction   
    global static TableRecord[] getTableChatForSelectedGroup(String selectedGroupId,String selectedGroupType) {
            date todayDate = date.today();
            string year = todayDate.year()+'';
            string month = (todayDate.month() - 6)+'';
            string stringDate = year + '-' + month + '-' + 1;
            Date sixMonthsBeforeDate = date.valueOf(stringDate);
            List<TableRecord> tableRecords = new List<TableRecord>();
            return tableRecords; 
    }       
    
    
    global with sharing class TableRecord{
        public String topInfluenceRank {get;set;}
        public String topUsers {get;set;}

        TableRecord(String topInfluenceRank,String topUsers) 
        {
            this.topInfluenceRank = topInfluenceRank;
            this.topUsers = topUsers;
        }
    }       
    
}