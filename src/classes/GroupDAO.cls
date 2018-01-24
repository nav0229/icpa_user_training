/****************************************************************
 Name: GroupDAO
============================================================
Author: Lenny
Purpose: Data Access Object for Group
============================================================

****************************************************************/

public interface GroupDAO {
	Group getGroupByDeveloperNameAndType(String devName, String groupType);
}