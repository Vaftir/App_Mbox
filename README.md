# Lista_Pessoal_Gerenciamento de estados

Uma aplicação simples envonvelndo de lista pessoal qualquer

## Resumo
Esse projeto e basicamente o mesmo da lista anterior a forma em que foi feito é diferrente
nele foi utilizado o recurso de Gerenciamento de estado. Nesse aplicativo em especifico foi
utolizado o MobX.

Esse Mobx se baseia em um recurso chamdo Observables que representam o estado do aplicativo
ao fazer uma interação nesses Observables todas as reações sao executadas novemente. Reações
podem ser qualquer coisa, desde um simples log do console, uma chamada de rede para renderizarnovamente a IU.

Obs: O loading no aplicativo e para demonstrar a o que seria a interação dos Observables  executando
as reações novamente


## Exemplos

Um exemplo do uso do MobX encontra se no pacote controller no arquivo produto.controller.dart
  "..."
       @observable
       AppStatus status = AppStatus.none;
       @observable
       ObservableList<Produto> list = ObservableList<Produto>();
  "..."

Aqui pode se dizer que ele mantém o estado da lista ate que uma acao seja tomada se houver uma modificação


