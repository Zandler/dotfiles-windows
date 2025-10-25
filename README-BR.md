# DOTFILES WINDOWS

```
Quando se cria burocracia o **DEV** intervém com gambiarra
```
### Requisitos
- Windows 11 com as ultimas atualizações
- Powershell na verão maior que 5

### Instruções:
Não é ncessário ser admin para quase nada, exceto instalar o WSL. Ele checa caso seja admin, instala wsl, caso contrário ele pula esse passo.

```powershell
 Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Iwr -Uri https://raw.githubusercontent.com/Zandler/dotfiles-windows/refs/heads/main/install.ps1 -OutFile install.ps1; ./install.ps1
```
**O que é instalado?**
caso queira saber oq ue é instalado, abra o arquivo boostrap.ps1 e vá a linha 78. Entenda que aqui tem o que EU preciso e voce é livre para modificar e colocar de acordo co seu contexto.

**PS**
Fique a vontade para fazer um fork e propor melhorias. 


# ADR deste repositório
Aqui o por que deste repo existir

### Objetivo
Criar um script para instalar tudo que preciso para atuar como SRE/Arquiteto em organizações com estações trabalho limitadas. 

### Status
Liberado o script com tudo que preciso de forma automatizada para quem quiser aproveitar.

### Contexto
Com a quantidade de incidentes, o foco passou ser segurança nas estações de trabalho. Então preciso de uma alternativa que eviter ficar abrindo chamado para instalação de aplicativos necessários bem como configurar meu ambiente de maneira que melhore minha produtividade

### Desição
Após buscar por ferramentas que facilitassem meu trabalho escrevi esses scripts para conseguir trabalhar. 

### Consequências
Quando preciso mover de uma estação de trabalho eu levo apenas um copia e cola para configurar. Mas demora pois preciso instalar um *mucado* de coisa

### O que voce vai encontrar ao final da instalação?
- *syntax-highligth*: cor para o terminal quando existir um comando
- *Auto complete com predição*: Não tem Ia, é só um truque mesmo
- A maioria dos aplicativos necessários para uso no dia a dia
