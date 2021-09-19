##
## EPITECH PROJECT, 2019
## B-FUN-300-PAR-3-3-pushswapchecker-benjamin.reigner
## File description:
## Makefile
##

HFLAGS	=	-Wall -Wextra

TFLAGS	=	-fhpc

GHC		=	ghc

RM		?=	rm -f

NAME	=	pushswap_checker

MAIN	+=	src/Main.hs

MOBJ	+=	$(MAIN:.hs=.hi)
MOBJ	+=	$(MAIN:.hs=.o)

SRC		+=	src/pushswapChecker.hs

OBJ		+=	$(SRC:.hs=.hi)
OBJ		+=	$(SRC:.hs=.o)

TSRC	+=	tests/Main.hs
TSRC	+=	tests/test_pushswapChecker.hs

TOBJ	+=	$(TSRC:.hs=.hi)
TOBJ	+=	$(TSRC:.hs=.o)

all: $(NAME)

$(NAME): $(SRC) $(MAIN)
	$(GHC) $(HFLAGS) -o $(NAME) $(MAIN) $(SRC)

tests_run: $(SRC) $(TSRC)
	$(RM) unit_test.tix
	$(GHC) $(HFLAGS) -o unit_test $(TSRC) $(SRC) $(TFLAGS)

clean:
	$(RM) $(MOBJ)
	$(RM) $(OBJ)
	$(RM) $(TOBJ)
	$(RM) unit_test.tix
	$(RM) -r .hpc/

fclean: clean
	$(RM) $(NAME)
	$(RM) unit_test

re: fclean all

.PHONY: all clean fclean re
