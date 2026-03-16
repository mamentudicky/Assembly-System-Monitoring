%define STDOUT 1
%define SYS_EXIT     1
%define SYS_WRITE    4
%define SYS_READ     3
%define SYS_OPEN     5
%define SYS_CLOSE    6
%define SYS_GETLOADAVG 304
%define SYS_SYSINFO  116
%define SYS_TIMES    100
%define SYS_NANOSLEEP 162
%define O_RDONLY     0

; sysinfo offsets (i386)
%define SYSINFO_UPTIME     0
%define SYSINFO_LOADS      4
%define SYSINFO_TOTALRAM   16
%define SYSINFO_FREERAM    20
%define SYSINFO_PROCS      80

; tms offsets
%define TMS_UTIME 0
%define TMS_STIME 4
%define TMS_CUTIME 8
%define TMS_CSTIME 12
