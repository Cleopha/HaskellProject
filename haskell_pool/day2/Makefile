##
## EPITECH PROJECT, 2021
## makefile
## File description:
## makefil
##

CC		=		ghc

MAKEFLAGS	+=	--no-print-directory

#CFLAGS	+= -Wall -Wextra

CPPFLAGS	=	-I./include

TFLAGS	=	-lcriterion --coverage

#LFLAGS	= -L./lib

NAME	=	doop

SRC		=	DoOp.hs	

MAIN	=	

MOBJ	=	$(MAIN:.hs=.o)

OBJ		=	$(SRC:.hs=.o)

HOBJ	=	$(SRC:.hs=.hi)

TSRC	=	tests/test.hs

TOBJ	=	$(TSRC:.hs=.o)

ifdef DEBUG
	CFLAGS += -ggdb3
endif

%.o:	%.hs
	@$(CC) -no-pie $(CFLAGS) $(CPPFLAGS) -c -o $@ $< && \
	(echo "\033[92m[ OK ]\033[0m" $<) || \
	(echo "\033[91m[ NO COMPIL ]\033[0m" $<; false)

all:	$(NAME)

$(NAME):	$(OBJ)	$(MOBJ)
	@$(CC) -no-pie $(MOBJ) $(OBJ) -o $(NAME) $(LFLAGS)

tests_run:	CPPFLAGS += --coverage

tests_run:	$(OBJ) $(TOBJ)
	@$(CC) -o unit_test $(OBJ) $(TOBJ) $(LFLAGS) $(TFLAGS)
		./unit_test
		gcovr -b --exclude-directories tests

clean:
	@echo "\033[91m[ RM ]\033[0m $(OBJ)"
	@rm -f $(OBJ) $(MOBJ) $(TOBJ) $(HOBJ)
	@rm -f src/*.gcda
	@rm -f src/*.gcno
	@rm -f tests/*.gcda
	@rm -f tests/*.gcno

fclean: clean
	@echo  "\033[91m[ RM ]\033[0m Binary"
	@rm -f $(NAME) unit_test

re: fclean all

.PHONY: all clean fclean re
