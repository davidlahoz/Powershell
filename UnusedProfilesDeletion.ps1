#
# This script uses Delprof2 Delprof2 by Helge Klein - https://helgeklein.com/free-tools/delprof2-user-profile-deletion-tool/
#LOCAL USAGE
#
#Save hostname to variable
$hostname=hostname
#run command with variable in it
#CMD COMMAND IS: delprof2 /c:HOSTNAME /ed:admin* /ed:Ctx* /ed:all* /ed:Clas* /u
#Need to change RunPath
$runpath = "c:\temp\assets\delprof.exe"
#Due personal needs it excludes (/ed) few type of user profiles
$arguments = "/c:$hostname /ed:admin* /ed:Ctx* /ed:all* /ed:Clas* /u"
Start-Process -filepath $runpath -Verb runAs -ArgumentList $arguments 
#
#Delprof2 command notes:
# Usage: delprof2 [/l] [/u] [/q] [/p] [/r] [/c:[\\]<computername>] [/d:<days> [/ntuserini]] [/ed:<pattern>] [/id:<pattern>] [/i]
#        /l   List only, do not delete (what-if mode)
#        /u   Unattended (no confirmation)
#        /q   Quiet (no output and no confirmation)
#        /p   Prompt for confirmation before deleting each profile
#        /r   Delete local caches of roaming profiles only, not local profiles
#        /c   Delete on remote computer instead of local machine
#        /d   Delete only profiles not used in x days
#        /ntuserini
#             When determining profile age for /d, use the file NTUSER.INI
#             instead of NTUSER.DAT for age calculation
#        /ed  Exclude profile directories whose name matches this pattern
#             Wildcard characters * and ? can be used in the pattern
#             May be used more than once and can be combined with /id
#        /id  Include only profile directories whose name matches this pattern
#             Wildcard characters * and ? can be used in the pattern
#             May be used more than once and can be combined with /ed
#        /i   Ignore errors, continue deleting