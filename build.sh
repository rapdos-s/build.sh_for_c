#!/bin/bash

# Nome do binário e arquivos fonte #############################################
binary_name="hello.out"
source_files="main.c"
object_files=$(echo $source_files | sed 's/\.c/\.o/g')

# Compilador e flags ###########################################################
# Nota: Letras aqui foram usadas porque variáveis padrões do make são em maiúsculas
CC="gcc"
CFLAGS="-Wall -Wextra -Werror"
del="rm -f"

# Mostra a ajuda ###############################################################
show_help()
{
    echo "Uso:"
    echo "  $0 all   : compila todos os arquivos .c para .o e gera o binário"
    echo "  $0 $binary_name : como só tem um binário, compila o binário igual o all"
    echo "  $0 clean : remove todos os arquivos .o"
    echo "  $0 fclean: remove todos os arquivos .o e o binário"
    echo "  $0 re    : remove todos os arquivos .o, compila todos os arquivos .c para .o e gera o binário"
}

# all ##########################################################################
all()
{
    # Essa variável ativa quando algum objeto foi criado e precisa recompilar o binário
    need_recompile="noup"

    # Esse loop pega cada arquivo .c e compila para .o
    # O if dentro do loop verifica se o arquivo .c é mais novo que o .o,
    # evitando compilar arquivos desnecessários

    # para arquivo em $source_files; faça
    for file in $source_files; do
        # se [ arquivo não existe ]; então
        if [ ! -f $(echo $file) ]; then
            echo "Arquivo $file não existe"
            exit 1
        fi

        # se [ arquivo.c é mais novo que arquivo.o ]; então
        if [ $file -nt $(echo $file | sed 's/\.c/\.o/g') ]; then
            echo "Compilando $(echo $file | sed 's/\.c/\.o/g')"
            $CC $CFLAGS -c $file -o $(echo $file | sed 's/\.c/\.o/g')
            need_recompile="yep"
        fi
    done

    # Compila o binário se for necessário
    if [ "$need_recompile" = "yep" ]; then
        echo "Compilando $binary_name"
        $CC $CFLAGS $object_files -o $binary_name
    fi
}

clean()
{
    echo "Removendo arquivos intermediários"
    $del $object_files
}

fclean()
{
    # Chama a função clean para limpar os arquivos intermediários
    clean

    echo "Removendo $binary_name"
    $del $binary_name
}

re()
{
    # Chama a função fclean para limpar os arquivos intermediários e o binário
    fclean

    # Chama a função all para compilar todos os arquivos .c para .o e gerar o binário
    all
}

# Check the argument and call the appropriate function #########################

# Se tiver mais que um argumento, chama a função show_help e sai
[ $# -gt 1 ] && show_help && exit 1

# Se não tiver um argumento, chama o "all" e sai
[ $# -eq 0 ] && all && exit 0

# Se o argumento for "all", chama a função all e sai
[ "$1" = "all" ] && all && exit 0

# Se o argumento for o nome do binário, chama a função all e sai
[ "$1" = "$binary_name" ] && all && exit 0

# Se o argumento for "clean", chama a função clean e sai
[ "$1" = "clean" ] && clean && exit 0

# Se o argumento for "fclean", chama a função fclean e sai
[ "$1" = "fclean" ] && fclean && exit 0

# Se o argumento for "re", chama a função re e sai
[ "$1" = "re" ] && re && exit 0

# Caso contrário, chama a função show_help e sai
show_help && exit 1

################################################################################
