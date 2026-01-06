# DOTFILES-WINDOWS

![](./img/terminal.png)
Assim fica quando terminar

![](./img/terminal-predict.png)
Terminal com auto completar com histórico

![](./img/hx-complete.png)
Editor Helix com recursos completos para golang, python

## RECURSOS
- Destaque de sintaxe
- Completar comandos e visualização
- Ferramentas SRE como kubectl, terraform, k9s, etc.
- Aliases e atalhos do Git
- Aliases do Kubernetes com kubecolor
- Experiência moderna de terminal com prompt Starship

### Usuários Gopher
**air** para desenvolvimento local reiniciar após salvar

### Python
**uv** para gerenciamento de ambiente e pacotes

### SRE's
Kubecolor

e outras coisas

### **POR FAVOR, LEIA OS ARQUIVOS ! ! !**

## O que é
Este repositório contém scripts PowerShell e arquivos de configuração. Você pode configurar seu ambiente para trabalho SRE!

**Não precisa de direitos de administrador**

## Requisitos

- Windows 11 (recomendado: ambiente limpo)
- PowerShell > 5

## Instruções

1. Atualize seu sistema
2. Execute este comando no PowerShell **(Não precisa de admin local)**

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Iwr -Uri https://raw.githubusercontent.com/Zandler/dotfiles-windows/refs/heads/main/install.ps1 -OutFile install.ps1; ./install.ps1
```

Após a instalação, feche o terminal e abra novamente. **Voilà**

**PS**
Nao esquece de ir em configuracoes no terminal e alterar a fonta ara jetbrains nerdfont NL

![](./img/terminal.png)

Este script:
- Instala o gerenciador de pacotes Scoop
- Instala o Git
- Clona este repositório
- Instala aplicativos de desenvolvimento
- Configura o terminal
- Instala WSL (se você for admin local, caso contrário pula esta etapa)

**Se você quiser ver ou instalar mais software, vá para https://scoop.sh/#/apps e procure seu aplicativo.**

depois, abra bootstrap.ps1 na linha 87 e adicione seu pacote

Após a execução, instale o WSL:

```powershell
wsl --install -d Ubuntu
```

Se você precisar configurar o ambiente Linux, vá para a pasta dotfiles e configure o Linux: **[Linux-dotfiles](https://github.com/Zandler/dotfiles)**

## Aliases Disponíveis

### Aliases do Sistema de Arquivos
| Comando | Executa | Descrição | Exemplo |
|---------|---------|-----------|---------|
| `ls` | `eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons` | Listagem aprimorada de diretório com ícones e status do git | `ls` |
| `ll` | `eza --tree --level=2 --color=always --group-directories-first --icons` | Visualização em árvore de diretórios (2 níveis) | `ll` |

### Aliases do Git
| Comando | Executa | Descrição | Exemplo |
|---------|---------|-----------|---------|
| `ga` | `git add .` | Adicionar todas as alterações ao staging | `ga` |
| `gca` | `git commit --amend --verbose` | Alterar último commit com saída detalhada | `gca` |
| `gco` | `git checkout` | Fazer checkout de branch ou commit | `gco main` |
| `gcob` | `git checkout -b` | Criar e fazer checkout de nova branch | `gcob feature/nova-funcionalidade` |
| `glbm` | `git for-each-ref --sort=-committerdate --format='%(refname:short) %09 %(committerdate:relative)' refs/heads/` | Listar branches locais por última modificação | `glbm` |
| `glbmr` | `git for-each-ref --sort=-committerdate --format='%(refname:short) %09 %(committerdate:relative)' refs/remotes/` | Listar branches remotas por última modificação | `glbmr` |
| `gs` | `git status -sb` | Status curto do git | `gs` |
| `gl` | `git log --oneline` | Log do git em uma linha | `gl` |
| `glc` | `git log -1 HEAD --stat` | Último commit com alterações de arquivos | `glc` |
| `grb` | `git branch -r -v` | Listar branches remotas com detalhes | `grb` |
| `gcm` | `git commit -m` | Commit com mensagem | `gcm "fix: bug no login"` |

### Aliases do Kubernetes (usando kubecolor)
| Comando | Executa | Descrição | Exemplo |
|---------|---------|-----------|---------|
| `k` | `kubecolor` | Comando base kubectl com cores | `k get pods` |
| `kgp` | `kubecolor get pods` | Obter pods | `kgp -n default` |
| `kgs` | `kubecolor get svc` | Obter serviços | `kgs -A` |
| `kgd` | `kubecolor get deploy` | Obter deployments | `kgd -n production` |
| `kgn` | `kubecolor get nodes` | Obter nós | `kgn` |
| `kgns` | `kubecolor get namespaces` | Obter namespaces | `kgns` |
| `kdp` | `kubecolor describe pod` | Descrever pod | `kdp meu-pod-123` |
| `kds` | `kubecolor describe svc` | Descrever serviço | `kds meu-servico` |
| `kdd` | `kubecolor describe deploy` | Descrever deployment | `kdd meu-deployment` |
| `kdn` | `kubecolor describe node` | Descrever nó | `kdn worker-node-1` |
| `kl` | `kubecolor logs` | Obter logs do pod | `kl meu-pod-123` |
| `klf` | `kubecolor logs -f` | Seguir logs do pod | `klf meu-pod-123` |
| `kex` | `kubecolor exec -it` | Executar comando no pod | `kex meu-pod-123 -- /bin/bash` |
| `kpf` | `kubecolor port-forward` | Encaminhar porta para pod/serviço | `kpf svc/meu-servico 8080:80` |
| `ka` | `kubecolor apply -f` | Aplicar arquivo YAML | `ka deployment.yaml` |
| `kd` | `kubecolor delete` | Deletar recurso | `kd pod meu-pod-123` |
| `kgc` | `kubecolor config get-contexts` | Obter contextos disponíveis | `kgc` |
| `kcc` | `kubecolor config use-context` | Trocar contexto | `kcc production` |

### Funções Utilitárias
| Comando | Descrição | Exemplo |
|---------|-----------|---------|
| `Get-GitBranch` | Obter branch atual do git para caminho especificado | `Get-GitBranch C:\meu-repo` |

Aproveite!!!