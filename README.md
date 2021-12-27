[![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)

# GHReposApp
A ideia do app é experimentar com micromodularização fazendo uso da ferramenta Tuist, que permite gerenciar e construir projetos modularizados, além de outras funcionalidades. Além disso, o app busca usar o máximo possível, e onde fizer sentido, a programação reativa, através da biblioteca RxSwift. A fim de gerenciar com mais facilidade o estado da aplicação, o app faz uso de estruturas chamadas de Reducers, derivadas da biblioteca Redux, porém a implementação no app tem influências do projeto Mobius.swift.

## Como rodar
Caso deseja utilizar o Tuist para gerar o projeto e executá-lo, por favor baixe o tuist e configure-o seguindo o seguinte [link](https://docs.tuist.io/tutorial/get-started). Após instalar, execute o comando `tuist generate --open` para abrir o projeto. Utilize o target `GHReposAppWorkspace-Project` para rodar os testes e o target `GHReposApp` para rodar o app.

Se preferir não realizar o processo de instalação e configuração do Tuist, basta clonar e rodar o .xcworkspace na raíz do projeto.

Testado com:
* Xcode 13.2
* macOS 12.0.1

Testes de snapshots foram realizados com o simulador iPhone 12 iOS 14.4.

## Dependências
* Tuist
* RxSwift
* SnapshotTesting

As licenças estão na pasta Licenses.

## Arquitetura
A arquitetura do app é feita de modo que a camada da View/ViewController seja separada do resto. O Presenter é usado para servir de ponto de comunicação entre a View/ViewController com o resto da arquitetura. Um Presenter não realiza tomadas de decisões de lógica de negócio, este objeto adapta informações para que a View/ViewController consiga mostrar, realiza chamadas de API criada pelo Interactor, assim como outras coisas. O Interactor, por sua vez, é uma estrutura que serve para construir as chamadas de API que o Presenter utilizará. Entretanto, nem o Presenter ou o Interactor, tomam decisões sobre qual chamada deve ser feita, se a View/ViewController deve mostrar um loading ou algo do tipo. Quem tem a função de gerenciar o estado da aplicação e como deve ser modificado, é o Reducer. Esta estrutura recebe o estado daquela tela, uma ação e retorna um objeto com o novo estado e algum efeito a ser realizado pelo Presenter. Um efeito pode ser, por exemplo, passar dados para a ViewController ou realizar uma chamada de API. Por último, o Router serve como uma estrutura para realizar a navegação entre as telas. Este objeto possui referências as Presenters e recebe input delas através de delegates.

```
View <---- ViewController <---- Presenter <---------- Router
                                    |_> Interactor
                                    |_> Reducer

> : Referência
```

## Referências e influências
[Tuist](https://docs.tuist.io/building-at-scale/microfeatures)

[Pointfree](https://www.pointfree.co)

[RxSwift](https://github.com/ReactiveX/RxSwift)

[Mobius.swift](https://github.com/spotify/Mobius.swift)

[Increment - Meet the microapps architecture](https://increment.com/mobile/microapps-architecture/)

