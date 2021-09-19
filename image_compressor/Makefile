##
## EPITECH PROJECT, 2021
## Makefile
## File description:
## Makefile
##

RM			?=	rm -rf

HFLAGS		=	--system-ghc

BINARY_FLAG	=	--local-bin-path .

NAME		=	imageCompressor

all:
	stack $(HFLAGS) build
	stack $(HFLAGS) $(BINARY_FLAG) install

clean:
	stack clean

fclean:	clean
	$(RM) $(NAME)

re:	fclean all

.PHONY: all clean fclean re
