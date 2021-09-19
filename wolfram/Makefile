##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## Makefile
##

RM	?=	rm -rf

stack	=	stack

NAME	=	wolfram

HFLAGS	=	--system-ghc

BINARY_FLAG	=	--local-bin-path .

all:
	@stack build $(HFLAGS)
	@stack install $(BINARY_FLAG) $(HFLAGS)
	@mv $(NAME)-exe $(NAME)

clean:
	@stack clean

fclean:	clean
	$(RM) $(NAME)

re:	fclean all

.PHONY: all clean fclean re