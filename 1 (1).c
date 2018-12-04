#include<stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include<semaphore.h>
#define N 10


/*to execute type gcc 1.c -pthread
after execution type ./a.out
*/

sem_t s1,s2,s3,s4,s5,s6,s7;//declaration of semaphores.

struct node					//node creation.
{
    int val;
    struct node *next;
}*freelist,*list1,*list2,*newnode,*temp,*t,*t1,*q;


int createlinkedlist() //freelist creation.
{
int i;

  		for(i=0;i<N;i++)
		{
		 if(freelist==NULL)
			{newnode=(struct node*)malloc(sizeof(struct node));
			newnode->val=i;
			newnode->next=NULL;
			freelist=newnode;
			temp=freelist;
			t=newnode;
			t1=freelist;
	 		}
		else 

     		{newnode=(struct node*)malloc(sizeof(struct node));
			newnode->val=i;
			newnode->next=NULL;
			temp->next=newnode;
			temp=newnode;
			if(i==N-1)
			{q=newnode;
			}
			
		    }
	
		}
}		

int createlinkedlist1(int q) //list1 creation.
{
		
		 if(list1==NULL)
			{newnode=(struct node*)malloc(sizeof(struct node));
			newnode->val=q;
			newnode->next=NULL;
			list1=newnode;
			temp=list1;
			t=newnode;
	 		}
		else 

     		      {newnode=(struct node*)malloc(sizeof(struct node));
			newnode->val=q;
			newnode->next=NULL;
			temp->next=newnode;
			temp=newnode;
							

		       }
	
}

int createlinkedlist2(int a) //list2 creation.
{
		 if(list2==NULL)
			{newnode=(struct node*)malloc(sizeof(struct node));
			newnode->val=a;
			newnode->next=NULL;
			list2=newnode;
			temp=list2;
			t=newnode;
	 		}
		else 

     		{newnode=(struct node*)malloc(sizeof(struct node));
			newnode->val=a;
			newnode->next=NULL;
			temp->next=newnode;
			temp=newnode;
						

		    }
	
}

int freelist_link(int x)
{sem_wait(&s1);
newnode=(struct node*)malloc(sizeof(struct node));
q->next=newnode;
newnode->next=NULL;
q=newnode;
freelist->val=x;
sem_post(&s4);
sem_post(&s1);
}	

void * thread1()//running thread-1;copying 
{
while(1)
{
sem_wait(&s4);
int b;
printf("CALLING AND EXECUTING THREAD1 \n");

sem_wait(&s1);//s1 is used to prevent interruption 

b=freelist->val;
freelist=freelist->next;
sem_post(&s1);//Releasing semaphore
printf("b=%d\n",b);
sem_wait(&s2);//s2 not to prevent interruption
createlinkedlist1(b);
sem_post(&s5);
sem_post(&s2);
sem_post(&s4);
sleep(1);
}
}

void * thread2()
{
while(1)
{
struct node *o;
int x,y;
printf("CALLING AND EXECUTING THREAD2\n");
sem_wait(&s5);

sem_wait(&s2);//s2 to prevent interruption
x=list1->val;
sem_post(&s2);//semaphore released

printf("x=%d\n",x);
sem_wait(&s4);

sem_wait(&s1);//s1 to prevent interruption
y=freelist->val;
freelist=freelist->next;
printf("y=%d\n",y);
sem_post(&s1);
freelist_link(x);
sem_wait(&s3);
y=10+x;
createlinkedlist2(y);
printf("y2=%d\n",y);
sem_post(&s3);
sem_post(&s6);
sleep(1);
}

}

void * thread3()
{
while(1)
{
struct node *o;
int c;
printf("CALLING AND EXECUTING THREAD3\n");

sem_wait(&s6);
sem_wait(&s3);//to prevent blocking c
c=list2->val;
sem_post(&s3);//releasing s3

printf("c=%d\n",c);

freelist_link(c);
sem_post(&s4);
sleep(1);
}
}

int main()
{int i;
createlinkedlist();
pthread_t tid1,tid2,tid3;
	sem_init(&s1,0,1);//semaphores initialization
	sem_init(&s2,0,1);
	sem_init(&s3,0,1);
	sem_init(&s4,0,N);
	sem_init(&s5,0,0);
	sem_init(&s6,0,0);
	sem_init(&s7,0,0);

	pthread_create(&tid1,NULL,thread1,NULL);//creating threads to access thread1
        
     
		
	pthread_create(&tid2,NULL,thread2,NULL);//
        
        //pthread_join(tid2,NULL);

	pthread_create(&tid3,NULL,thread3,NULL);
        //pthread_join(tid1,NULL);
	//pthread_join(tid2,NULL);
        pthread_join(tid3,NULL);



wait(10);
}
