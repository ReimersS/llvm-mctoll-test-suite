#include <stdio.h>
#include <stdint.h>

int __isoc99_fscanf (FILE *stream, const char *format, ...);
int __isoc99_sscanf (const char *format, ...);

int getopt(int argc, char *const argv[], const char *optstring);
char * optarg;
int optind;

void __assert_fail(const char * assertion, const char * file, unsigned int line, const char * function);

#include <sched.h>

/* Set the CPU affinity for a task */
extern int sched_setaffinity (__pid_t __pid, size_t __cpusetsize,
			      const cpu_set_t *__cpuset) __THROW;

/* Get the CPU affinity for a task */
extern int sched_getaffinity (__pid_t __pid, size_t __cpusetsize,
			      cpu_set_t *__cpuset) __THROW;

extern int __isoc99_scanf (const char * __format, ...);

#define __SIZEOF_SEM_T 32
typedef union
{
  char __size[__SIZEOF_SEM_T];
  long int __align;
} sem_t;


//int open(const char *pathname, int flags);
//int open(const char *pathname, int flags, mode_t mode);
//int creat(const char *pathname, mode_t mode);
int sem_init (sem_t *__sem, int __pshared, unsigned int __value);
int sem_wait (sem_t *__sem);
int sem_destroy (sem_t *__sem);
int sem_post (sem_t *__sem);

#include <sys/time.h>

int gettimeofday(struct timeval *restrict tv,
                        struct timezone *restrict tz);


// math
double cos(double);
double sin(double);
double sqrt(double);
double atan(double);
double acos(double);
double pow(double, double);
double exp(double);
double log(double);

float sinf(float);
float sqrtf(float);
float roundf(float);
float expf(float);


// arp/inet.h

     uint64_t
     htonll(uint64_t hostlonglong);

     uint32_t
     htonl(uint32_t hostlong);

     uint16_t
     htons(uint16_t hostshort);

     uint64_t
     ntohll(uint64_t netlonglong);

     uint32_t
     ntohl(uint32_t netlong);

     uint16_t
     ntohs(uint16_t netshort);

int * __errno_location(void);

#include <sys/types.h>

pid_t wait(int *status);
pid_t waitpid(pid_t pid, int *status, int options);


