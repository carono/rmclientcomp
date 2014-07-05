unit rcSets;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
//const
//ADD_PROJECT:cardinal = 4;

type
  TRedminePermissions = set of (rcEdit, rcRead);

type
  TRCPermissions = set of (ADD_PROJECT,
    EDIT_PROJECT,
    SELECT_PROJECT_MODULES,
    MANAGE_MEMBERS,
    MANAGE_VERSIONS,
    ADD_SUBPROJECTS,
    MANAGE_CATEGORIES,
    VIEW_ISSUES,
    ADD_ISSUES,
    EDIT_ISSUES,
    MANAGE_ISSUE_RELATIONS,
    MANAGE_SUBTASKS,
    SET_ISSUES_PRIVATE,
    SET_OWN_ISSUES_PRIVATE,
    ADD_ISSUE_NOTES,
    EDIT_ISSUE_NOTES,
    EDIT_OWN_ISSUE_NOTES,
    MOVE_ISSUES,
    DELETE_ISSUES,
    MANAGE_PUBLIC_QUERIES,
    SAVE_QUERIES,
    VIEW_ISSUE_WATCHERS,
    ADD_ISSUE_WATCHERS,
    DELETE_ISSUE_WATCHERS,
    LOG_TIME,
    VIEW_TIME_ENTRIES,
    EDIT_TIME_ENTRIES,
    EDIT_OWN_TIME_ENTRIES,
    MANAGE_PROJECT_ACTIVITIES,
    MANAGE_NEWS,
    COMMENT_NEWS,
    VIEW_DOCUMENTS,
    MANAGE_FILES,
    VIEW_FILES,
    MANAGE_WIKI,
    RENAME_WIKI_PAGES,
    DELETE_WIKI_PAGES,
    VIEW_WIKI_PAGES,
    EXPORT_WIKI_PAGES,
    VIEW_WIKI_EDITS,
    EDIT_WIKI_PAGES,
    DELETE_WIKI_PAGES_ATTACHMENTS,
    PROTECT_WIKI_PAGES,
    MANAGE_REPOSITORY,
    BROWSE_REPOSITORY,
    VIEW_CHANGESETS,
    COMMIT_ACCESS,
    MANAGE_RELATED_ISSUES,
    MANAGE_BOARDS,
    ADD_MESSAGES,
    EDIT_MESSAGES,
    EDIT_OWN_MESSAGES,
    DELETE_MESSAGES,
    DELETE_OWN_MESSAGES,
    VIEW_CALENDAR,
    VIEW_GANTT,
    ADD_DOCUMENTS,
    EDIT_DOCUMENTS,
    DELETE_DOCUMENTS);

procedure SetPermissionByName(var Permissions: TRCPermissions; Name: string);

implementation

procedure SetPermissionByName(var Permissions: TRCPermissions; Name: string);
begin
  case Name of
    'add_project': Permissions := Permissions + [add_project];
    'edit_project': Permissions := Permissions + [edit_project];
    'select_project_modules': Permissions := Permissions + [select_project_modules];
    'manage_members': Permissions := Permissions + [manage_members];
    'manage_versions': Permissions := Permissions + [manage_versions];
    'add_subprojects': Permissions := Permissions + [add_subprojects];
    'manage_categories': Permissions := Permissions + [manage_categories];
    'view_issues': Permissions := Permissions + [view_issues];
    'add_issues': Permissions := Permissions + [add_issues];
    'edit_issues': Permissions := Permissions + [edit_issues];
    'manage_issue_relations': Permissions := Permissions + [manage_issue_relations];
    'manage_subtasks': Permissions := Permissions + [manage_subtasks];
    'set_issues_private': Permissions := Permissions + [set_issues_private];
    'set_own_issues_private': Permissions := Permissions + [set_own_issues_private];
    'add_issue_notes': Permissions := Permissions + [add_issue_notes];
    'edit_issue_notes': Permissions := Permissions + [edit_issue_notes];
    'edit_own_issue_notes': Permissions := Permissions + [edit_own_issue_notes];
    'move_issues': Permissions := Permissions + [move_issues];
    'delete_issues': Permissions := Permissions + [delete_issues];
    'manage_public_queries': Permissions := Permissions + [manage_public_queries];
    'save_queries': Permissions := Permissions + [save_queries];
    'view_issue_watchers': Permissions := Permissions + [view_issue_watchers];
    'add_issue_watchers': Permissions := Permissions + [add_issue_watchers];
    'delete_issue_watchers': Permissions := Permissions + [delete_issue_watchers];
    'log_time': Permissions := Permissions + [log_time];
    'view_time_entries': Permissions := Permissions + [view_time_entries];
    'edit_time_entries': Permissions := Permissions + [edit_time_entries];
    'edit_own_time_entries': Permissions := Permissions + [edit_own_time_entries];
    'manage_project_activities': Permissions := Permissions + [manage_project_activities];
    'manage_news': Permissions := Permissions + [manage_news];
    'comment_news': Permissions := Permissions + [comment_news];
    'view_documents': Permissions := Permissions + [view_documents];
    'manage_files': Permissions := Permissions + [manage_files];
    'view_files': Permissions := Permissions + [view_files];
    'manage_wiki': Permissions := Permissions + [manage_wiki];
    'rename_wiki_pages': Permissions := Permissions + [rename_wiki_pages];
    'delete_wiki_pages': Permissions := Permissions + [delete_wiki_pages];
    'view_wiki_pages': Permissions := Permissions + [view_wiki_pages];
    'export_wiki_pages': Permissions := Permissions + [export_wiki_pages];
    'view_wiki_edits': Permissions := Permissions + [view_wiki_edits];
    'edit_wiki_pages': Permissions := Permissions + [edit_wiki_pages];
    'delete_wiki_pages_attachments': Permissions := Permissions + [delete_wiki_pages_attachments];
    'protect_wiki_pages': Permissions := Permissions + [protect_wiki_pages];
    'manage_repository': Permissions := Permissions + [manage_repository];
    'browse_repository': Permissions := Permissions + [browse_repository];
    'view_changesets': Permissions := Permissions + [view_changesets];
    'commit_access': Permissions := Permissions + [commit_access];
    'manage_related_issues': Permissions := Permissions + [manage_related_issues];
    'manage_boards': Permissions := Permissions + [manage_boards];
    'add_messages': Permissions := Permissions + [add_messages];
    'edit_messages': Permissions := Permissions + [edit_messages];
    'edit_own_messages': Permissions := Permissions + [edit_own_messages];
    'delete_messages': Permissions := Permissions + [delete_messages];
    'delete_own_messages': Permissions := Permissions + [delete_own_messages];
    'view_calendar': Permissions := Permissions + [view_calendar];
    'view_gantt': Permissions := Permissions + [view_gantt];
    'add_documents': Permissions := Permissions + [add_documents];
    'edit_documents': Permissions := Permissions + [edit_documents];
    'delete_documents': Permissions := Permissions + [delete_documents];
  end;
end;

end.
