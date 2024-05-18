# Ref: https://github.com/garybernhardt/dotfiles/blob/main/.githelpers
#
# The time massaging regexes start with ^[^<]* because that ensures that they
# only operate before the first "<". That "<" will be the beginning of the
# author name, ensuring that we don't destroy anything in the commit message
# that looks like time.
#
# The log format uses } characters between each field, and `column` is later
# used to split on them. A } in the commit subject or any other field will
# break this.

$YELLOW = "#F9E2AF"
$RED = "#f38ba8"
$BLUE = "#89B4FA"
$GREEN = "#A6E3A1"

$LOG_HASH = "%C(always,$($YELLOW))%h%C(always,reset)"
$LOG_ABSOLUTE_DATE = "%C(always,$($GREEN))(%ar)%C(always,reset)"
$LOG_RELATIVE_TIME = "%C(always,$($GREEN))%as%C(always,reset)"
$LOG_AUTHOR = "%C(always,$($BLUE))<%an>%C(always,reset)"
$LOG_SUBJECT = "%s"
$LOG_REFS = "%C(always,$($RED))%d%C(always,reset)"

$LOG_FORMAT = "$($LOG_HASH) $($LOG_RELATIVE_TIME) $($LOG_ABSOLUTE_DATE) $($LOG_AUTHOR) $($LOG_REFS) - $($LOG_SUBJECT)"

$BRANCH_PREFIX = "%(HEAD)"
$BRANCH_REF = "%(color:$($RED))%(color:bold)%(refname:short)%(color:reset)"
$BRANCH_HASH = "%(color:$($YELLOW))%(objectname:short)%(color:reset)"
$BRANCH_DATE = "%(color:$($GREEN))(%(committerdate:relative))%(color:reset)"
$BRANCH_AUTHOR = "%(color:$($BLUE))%(color:bold)<%(authorname)>%(color:reset)"
$BRANCH_CONTENTS = "%(contents:subject)"

$BRANCH_FORMAT = "$($BRANCH_PREFIX) $($BRANCH_REF) $($BRANCH_HASH) $($BRANCH_DATE) $($BRANCH_AUTHOR) - $($BRANCH_CONTENTS)"

function show_git_head
{
  pretty_git_log -1
  git show -p --pretty="tformat:"
}

function pretty_git_log
{
  # git log --graph --pretty="tformat:$($LOG_FORMAT)" --no-show-signature $args | pretty_git_format | Out-Host -Paging
  git log --graph --pretty="tformat:$($LOG_FORMAT)" --no-show-signature $args
}

function pretty_git_branch
{
  git branch -v --color=always --format=$BRANCH_FORMAT $args | pretty_git_format
}

function pretty_git_branch_sorted
{
  git branch -v --color=always --format=$BRANCH_FORMAT --sort=-committerdate $args | pretty_git_format
}

function pretty_git_format
{
  # Read input from the pipeline
  $input | ForEach-Object {
    # Perform the first replacement: remove " ago" and keep the rest
    $_ -replace '([^<]*) ago\)', '$1)' |
      # Perform the second replacement: remove ", X months" and keep the rest
      ForEach-Object { $_ -replace '([^<]*), \d+ .*months?\)', '$1)' }
    } |
      # Line up columns based on '}' delimiter
      ForEach-Object {
        $_ -replace '}', "`t"
      } |
      Format-Table -AutoSize -Wrap
}
