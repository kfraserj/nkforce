/*CSci4061 F2018 Assignment 2
section: 10
date:  11/10/18
*name:  Jake Johnson, Ren Jeik,Ju-Yu Chou Fu
*id: 5160192,5343975,5411243
*/
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include "comm.h"
#include "util.h"
#include <unistd.h>

#define BUF_SIZE 50

/* -----------Functions that implement server functionality -------------------------*/

/*
 * Returns the empty slot on success, or -1 on failure
 */
int find_empty_slot(USER * user_list) {
	// iterate through the user_list and check m_status to see if any slot is EMPTY
	// return the index of the empty slot
    int i = 0;
	for(i=0;i<MAX_USER;i++) {
    	if(user_list[i].m_status == SLOT_EMPTY) {
			return i;
		}
	}
	return -1;
}

/*
 * list the existing users on the server shell
 */
int list_users(int idx, USER * user_list)
{
	// iterate through the user list
	// if you find any slot which is not empty, print that m_user_id
	// if every slot is empty, print "<no users>""
	// If the function is called by the server (that is, idx is -1), then printf the list
	// If the function is called by the user, then send the list to the user using write() and passing m_fd_to_user
	// return 0 on success
	int i, flag = 0;
	char buf[MAX_MSG] = {}, *s = NULL;

	/* construct a list of user names */
	s = buf;
	strncpy(s, "---connecetd user list---\n", strlen("---connecetd user list---\n"));
	s += strlen("---connecetd user list---\n");
	for (i = 0; i < MAX_USER; i++) {
		if (user_list[i].m_status == SLOT_EMPTY)
			continue;
		flag = 1;
		strncpy(s, user_list[i].m_user_id, strlen(user_list[i].m_user_id));
		s = s + strlen(user_list[i].m_user_id);
		strncpy(s, "\n", 1);
		s++;
	}
	if (flag == 0) {
		strcpy(buf, "<no users>\n");
	} else {
		s--;
		strncpy(s, "\0", 1);
	}

	if(idx < 0) {
		printf(buf);
		printf("\n");
	} else {
		/* write to the given pipe fd */
		if (write(user_list[idx].m_fd_to_user, buf, strlen(buf) + 1) < 0)
			perror("writing to server shell");
	}

	return 0;
}

/*
 * add a new user
 */
int add_user(int idx, USER * user_list, int pid, char * user_id, int pipe_to_child, int pipe_to_parent)
{
	// populate the user_list structure with the arguments passed to this function
	// return the index of user added
  strcpy(user_list[idx].m_user_id, user_id);
  user_list[idx].m_pid = pid;
  user_list[idx].m_fd_to_user = pipe_to_child;
  user_list[idx].m_fd_to_server = pipe_to_parent;
  user_list[idx].m_status = SLOT_FULL;

	return idx;
}

/*
 * Kill a user
 */
void kill_user(int idx, USER * user_list) {
	// kill a user (specified by idx) by using the systemcall kill()
	// then call waitpid on the user
    kill(user_list[idx].m_pid,SIGKILL);
    //waitpid(user_list[idx].m_pid);
}

/*
 * Perform cleanup actions after the used has been killed
 */
void cleanup_user(int idx, USER * user_list)
{
  user_list[idx].m_pid = -1;
  memset(user_list[idx].m_user_id, '\0', MAX_USER_ID);
  close(user_list[idx].m_fd_to_user);
  close(user_list[idx].m_fd_to_server);
  user_list[idx].m_fd_to_user = -1;
  user_list[idx].m_fd_to_server = -1;
  user_list[idx].m_status = SLOT_EMPTY;
}

/*
 * Kills the user and performs cleanup
 */
void kick_user(int idx, USER * user_list) {
  char die[] = "You have been kicked by the admin.";
  // send a message to notify a user that they are going to be terminated
  write(user_list[idx].m_fd_to_user, die, BUF_SIZE);
  // sleep. make sure the message reaches before the child process got killed
  usleep(10000);
  kill_user(idx, user_list);
  cleanup_user(idx, user_list);
}

/*
 * broadcast message to all users
 */
int broadcast_msg(USER * user_list, char *buf, char *sender)
{
	char temp[MAX_MSG];
	int flag = 0;
	if(strcmp(sender,"admin")==0){
		sprintf(temp,"%s: %s",sender,buf);
		flag = 1;
	}
	int i = 0;
	for(i;i<MAX_USER;i++){
       	if(user_list[i].m_status == SLOT_FULL){
            if(strcmp(user_list[i].m_user_id,sender)!=0){
		if(flag == 1){
               		if (write(user_list[i].m_fd_to_user, temp, strlen(temp) + 1) < 0){
                    		perror("writing to server shell");
                    		return -1;
                	}
		}
		else if(write(user_list[i].m_fd_to_user, buf, strlen(buf) + 1) < 0){
                    perror("writing to server shell");
                    return -1;
                }
            }

       	}
	}
	//iterate over the user_list and if a slot is full, and the user is not the sender itself,

	//then send the message to that user
	//return zero on success
	return 0;
}

/*
 * Cleanup user chat boxes
 */
void cleanup_users(USER * user_list)
{
	// go over the user list and check for any empty slots
	// call cleanup user for each of those users.
  for(int x = 0; x < MAX_USER; x++){
    if(user_list[x].m_status == SLOT_FULL){
      kick_user(x, user_list);
    }
  }
  printf("shut down the server\n");
  exit(1);
}

/*
 * find user index for given user name
 */
int find_user_index(USER * user_list, char * user_id)
{
	// go over the  user list to return the index of the user which matches the argument user_id
	// return -1 if not found
	int i, user_idx = -1;

	if (user_id == NULL) {
		fprintf(stderr, "NULL name passed.\n");
		return user_idx;
	}
	for (i=0;i<MAX_USER;i++) {
		if (user_list[i].m_status == SLOT_EMPTY)
			continue;
		if (strcmp(user_list[i].m_user_id, user_id) == 0) {
			return i;
		}
	}

	return -1;
}

/*
 * given a command's input buffer, extract name
 */
int extract_name(char * buf, char * user_name)
{
	char inbuf[MAX_MSG];
    char * tokens[16];
    strcpy(inbuf, buf);

    int token_cnt = parse_line(inbuf, tokens, " ");

    if(token_cnt >= 2) {
        strcpy(user_name, tokens[1]);
        return 0;
    }

    return -1;
}

int extract_text(char *buf, char * text)
{
    char inbuf[MAX_MSG];
    char * tokens[16];
    char * s = NULL;
    strcpy(inbuf, buf);

    int token_cnt = parse_line(inbuf, tokens, " ");

    if(token_cnt >= 3) {
        //Find " "
        s = strchr(buf, ' ');
        s = strchr(s+1, ' ');

        strcpy(text, s+1);
        return 0;
    }

    return -1;
}

/*
 * send personal message
 */
void send_p2p_msg(int idx, USER * user_list, char *buf)
{
	/* get the target user by name using extract_name() function */
	/* find the user id using find_user_index() */
	/* if user not found, write back to the original user "User not found", using the write()function on pipes. */
	/* if the user is found then write the message that the user wants to send to that user. */
	if(write(user_list[idx].m_fd_to_user,buf,strlen(buf) +1)<0)
		perror("could not send message");

}

//takes in the filename of the file being executed, and prints an error message stating the commands and their usage
void show_error_message(char *filename)
{
}


/*
 * Populates the user list initially
 */
void init_user_list(USER * user_list) {

	//iterate over the MAX_USER
	//memset() all m_user_id to zero
	//set all fd to -1
	//set the status to be EMPTY
	int i=0;
	for(i=0;i<MAX_USER;i++) {
		user_list[i].m_pid = -1;
		memset(user_list[i].m_user_id, '\0', MAX_USER_ID);
		user_list[i].m_fd_to_user = -1;
		user_list[i].m_fd_to_server = -1;
		user_list[i].m_status = SLOT_EMPTY;
	}
}

/* ---------------------End of the functions that implementServer functionality -----------------*/


/* ---------------------Start of the Main function ----------------------------------------------*/
int main(int argc, char * argv[])
{
	int nbytes;
	setup_connection("ggininder"); // Specifies the connection point as argument.

	USER user_list[MAX_USER];
	init_user_list(user_list);   // Initialize user list

	char buf[MAX_MSG];
	fcntl(0, F_SETFL, fcntl(0, F_GETFL)| O_NONBLOCK);
	print_prompt("admin");
	//
	while(1) {
		/* ------------------------YOUR CODE FOR MAIN--------------------------------*/
		// Handling a new connection using get_connection
    int pid, i, j, user_idx;
    int server_command_num, user_command_num;

    int pipe_child_writing_to_user[2];
    int pipe_child_reading_from_user[2];

		int pipe_server_reading_from_child[2];
		int pipe_server_writing_to_child[2];
		char user_id[MAX_USER_ID];
    char server_command[BUF_SIZE];
    char server_command_buff[BUF_SIZE];


    if (get_connection(user_id, pipe_child_writing_to_user, pipe_child_reading_from_user) > -1){
      // Server process: Add a new user information into an empty slot
      user_idx = find_empty_slot(user_list);
      pipe(pipe_server_reading_from_child);
      pipe(pipe_server_writing_to_child);

      printf("%s has joined.\n", user_id);

       //blocking for input or output

      int flag1 = fcntl(pipe_server_writing_to_child[0], F_GETFL, 0);
      int flag2 = fcntl(pipe_child_writing_to_user[1], F_GETFL, 0);
      int flag3 = fcntl(pipe_child_reading_from_user[0], F_GETFL, 0);
      int flag4 = fcntl(pipe_server_reading_from_child[1], F_GETFL, 0);
      fcntl(pipe_server_writing_to_child[0], F_SETFL, flag1 | O_NONBLOCK);
      fcntl(pipe_child_writing_to_user[1], F_SETFL, flag2 | O_NONBLOCK);
      fcntl(pipe_child_reading_from_user[0], F_SETFL, flag3 | O_NONBLOCK);
      fcntl(pipe_server_reading_from_child[1], F_SETFL, flag4 | O_NONBLOCK);

      pid = fork ();
      int add_return = add_user(user_idx, user_list, pid, user_id, pipe_server_writing_to_child[1], pipe_server_reading_from_child[0]);
      if (pid == -1){
        perror ("fork problem");
        close(pipe_server_reading_from_child[1]);
        close(pipe_server_writing_to_child[1]);
        close(pipe_server_reading_from_child[0]);
        close(pipe_server_writing_to_child[0]);
        close(pipe_child_writing_to_user[1]);
        close(pipe_child_writing_to_user[0]);
        close(pipe_child_reading_from_user[1]);
        close(pipe_child_reading_from_user[0]);
        exit (-1);
      }

      // poll child processes and handle user commands
      else if (pid == 0){
        while(1){
          char childtemp1[BUF_SIZE], childtemp2[BUF_SIZE];
          int a, b;
          if((a = read(pipe_server_writing_to_child[0], childtemp1, BUF_SIZE)) > 0){
            write(pipe_child_writing_to_user[1], childtemp1, a);
          }
          if((b = read(pipe_child_reading_from_user[0], childtemp2, BUF_SIZE)) > 0){
            write(pipe_server_reading_from_child[1], childtemp2, b);
          }
          usleep(5000);
        }
      }
    }
    //server to go through list and check each node and see if clients have sent anything to child process
    int flag5 = fcntl(pipe_server_reading_from_child[0], F_GETFL, 0);
    fcntl(pipe_server_reading_from_child[0], F_SETFL, flag5 | O_NONBLOCK);
    char buffer1[BUF_SIZE];
    char error_message[MAX_MSG];
    char command_from_user[BUF_SIZE];
	  char token3[MAX_MSG];
	  char token4[MAX_MSG];
    char final_user[MAX_MSG];
	  int index2, user_ind;
    for(int x = 0; x < MAX_USER; x++){
      if(user_list[x].m_status == SLOT_FULL){
        if((j = read(user_list[x].m_fd_to_server, buffer1, BUF_SIZE)) > 0){
          strcpy(command_from_user, buffer1);
          char sender[MAX_MSG];
          strcpy(sender, user_list[x].m_user_id);
          user_command_num = get_command_type(command_from_user);
          switch (user_command_num) {
            case 0:
              list_users(x, user_list);
              break;
            case 2:
                if(extract_name(buffer1,token3)!=0){
                  strcpy(error_message, "failed to find name");
                  write(user_list[x].m_fd_to_user, error_message, strlen(error_message) + 1);
                  break;
                }
                if((index2 = find_user_index(user_list,token3)) == -1){
                  strcpy(error_message, "This user is currently not online.");
                  write(user_list[x].m_fd_to_user, error_message, strlen(error_message) + 1);
                  break;
                }
		            if(extract_text(buffer1,token4) !=0){
                  strcpy(error_message, "could not get text.");
                  write(user_list[x].m_fd_to_user, error_message, strlen(error_message) + 1);
                  break;
                }
                // build p2p format-> sender: message
                strcpy(final_user, sender);
                strcat(final_user, " whispers: ");
                strcat(final_user, token4);
           	    send_p2p_msg(index2, user_list, final_user);
        	      break;
            case 4:
              user_ind = find_user_index(user_list, user_list[x].m_user_id);
              kick_user(user_ind, user_list);
              break;
            default:
            // build broadcast format-> sender: message
              strcpy(final_user, sender);
              strcat(final_user, " yells: ");
              strcat(final_user, buffer1);
              broadcast_msg(user_list,final_user,user_list[x].m_user_id);
              printf("%s \n",final_user);
              break;
          }

        }
      }
    }

    // Poll stdin (input from the terminal) and handle admnistrative command
    if((i = read(0, server_command_buff, BUF_SIZE)) > 0){
      if(i == 1){ //handle empty input and avoid segmentation fault
        continue;
      }
    server_command_buff[i-1] = '\0';
    strcpy(server_command, server_command_buff);
    server_command_num = get_command_type(server_command);
    char* myt;
    char* myt2;
    char final_admin[MAX_MSG];
	  char token[MAX_MSG];
	  char token2[MAX_MSG];
	  int index;
    int user_ind;
      switch (server_command_num) {
        case 0:
          list_users(-1, user_list);
          break;
        case 1:
          myt = strtok(server_command_buff, " ");
          while(myt!=NULL){
            myt2 = myt;
            myt = strtok(NULL," ");
          }
          user_ind = find_user_index(user_list, myt2);
          if(user_ind == -1){
            perror("could not find user");
            break;
          }
          kick_user(user_ind, user_list);
          break;
        case 2:
          if(extract_name(server_command_buff,token)!=0){
		 	       perror("failed to find name");
             break;
          }
          if((index = find_user_index(user_list,token)) == -1){
            printf("%s is not on the user_list\n", token);
            break;
          }
		      if(extract_text(server_command_buff,token2) !=0){
			       perror("could not get text");
             break;
          }
          // build p2p format-> admin: message
          strcpy(final_admin, "admin whispers: ");
          strcat(final_admin, token2);
          send_p2p_msg(index, user_list, final_admin);
        	break;
        case 4:
          cleanup_users(user_list);
          break;
        default:
          broadcast_msg(user_list, server_command_buff,"admin");
          break;
      }
    }
   usleep(5000);
		/* ------------------------YOUR CODE FOR MAIN--------------------------------*/
	}
}

/* --------------------End of the main function ----------------------------------------*/
