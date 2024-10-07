# Build Script (`build.sh`)

Este script `build.sh` automatiza o processo de compilação de um projeto em C, gerenciando dependências entre arquivos fonte e objetos. Ele evita recompilações desnecessárias, compilando apenas arquivos `.c` que foram modificados em relação aos seus correspondentes `.o`. O script também oferece opções para limpar arquivos intermediários e recompilar o projeto por completo, funcionando de maneira semelhante a um `Makefile`.

## Funcionalidades:
- **Compilação incremental**: Compila apenas os arquivos `.c` modificados.
- **Geração automática de dependências**: Arquivos `.d` são usados para rastrear dependências de arquivos `.h`.
- **Comandos disponíveis**:
  - `./build.sh all`: Compila todos os arquivos `.c` para `.o` e gera o binário final.
  - `./build.sh clean`: Remove arquivos objetos (`.o`) e arquivos de dependências (`.d`).
  - `./build.sh fclean`: Remove os arquivos objetos, dependências e o binário.
  - `./build.sh re`: Executa `fclean` e recompila o projeto do zero.
- **Gerenciamento de dependências**: Arquivos `.d` são gerados para garantir que arquivos `.h` sejam corretamente incluídos na recompilação quando modificados.

## Exemplo de usos:

- Para compilar o projeto:
```bash
./build.sh
```

- Para executar o binário de saída:
```bash
./hello.out
```

## Lista de tarefas:
- [x] Compilação básica;
- [x] Limpeza básica de arquivos;
- [x] Evitar compilação de objetos atualizados;
- [ ] Tradução para inglês;
- [ ] Adição de um sistema de dependências.
