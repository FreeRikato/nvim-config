return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  config = function()
    require('orgmode').setup {
      -- Basic file locations
      org_agenda_files = '~/org/**/*',
      org_default_notes_file = '~/org/refile.org',

      -- TODO keywords with fast access keys
      org_todo_keywords = {'TODO(t)', 'NEXT(n)', 'WAITING(w)', '|', 'DONE(d)', 'CANCELLED(c)'},
      org_todo_repeat_to_state = 'TODO',

      -- Priority settings
      org_priority_highest = 'A',
      org_priority_default = 'B',
      org_priority_lowest = 'C',

      -- Display settings
      org_hide_leading_stars = true,
      org_hide_emphasis_markers = true,
      org_ellipsis = '…',
      org_tags_column = -80,
      org_startup_folded = 'overview',
      org_log_done = 'time',
      org_log_repeat = 'time',

      -- Archive settings
      org_archive_location = '%s_archive::',

      -- Agenda settings
      org_agenda_span = 'week',
      org_agenda_start_on_weekday = 1,
      org_deadline_warning_days = 14,
      org_agenda_skip_scheduled_if_done = true,
      org_agenda_skip_deadline_if_done = true,

      -- Capture templates
      org_capture_templates = {
        t = {
          description = 'Task',
          template = '* TODO %?\n  %U\n  %a',
          target = '~/org/tasks.org'
        },
        n = {
          description = 'Note',
          template = '* %U %?\n  %a',
          target = '~/org/notes.org'
        },
        j = {
          description = 'Journal',
          template = '\n*** %U\n**** %?\n\n%?',
          target = '~/org/journal.org'
        },
        m = {
          description = 'Meeting',
          template = '* MEETING %? :meeting:\n  %U\n  - Attendees:\n  - Notes:\n  - Action Items:\n    - TODO %?',
          target = '~/org/meetings.org'
        },
        p = {
          description = 'Project',
          template = '* PROJECT %? :project:\n  :PROPERTIES:\n  :CREATED: %U\n  :END:\n  - Vision:\n  - Status:\n  - Next Steps:\n    - TODO %?',
          target = '~/org/projects.org'
        },
        r = {
          description = 'Reading List',
          template = '* TODO Read %? :reading:\n  %U\n  %a',
          target = '~/org/reading.org'
        },
        i = {
          description = 'Idea',
          template = '* IDEA %? :idea:\n  %U\n  %a',
          target = '~/org/ideas.org'
        }
      },

      -- Custom TODO keyword faces
      org_todo_keyword_faces = {
        WAITING = ':foreground blue :weight bold',
        NEXT = ':foreground #FF6B35 :weight bold',
        CANCELLED = ':foreground #8B8B8B :slant italic',
      },

      -- Window settings
      win_split_mode = 'auto',
      win_border = 'rounded',
      org_src_window_setup = 'top 16new',

      -- Tags settings
      org_tags_exclude_from_inheritance = {'ARCHIVE'},

      -- Indentation settings
      org_adapt_indentation = true,
      org_indent_mode_turns_off_org_adapt_indentation = true,
      org_indent_mode_turns_on_hiding_stars = true,

      -- Table formatting
      org_blank_before_new_entry = {
        heading = true,
        plain_list_item = false
      }
    }
  end,
}
