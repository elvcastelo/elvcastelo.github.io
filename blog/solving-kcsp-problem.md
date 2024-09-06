+++
title = "O problema do caminho mínimo com no máximo k cores"
description = "Discutiremos o problema de encontrar um caminho de custo mínimo em um grafo ponderado com coloração de arestas. Trata-se de um problema NP-difícil."
date = "21 de Agosto"
category = "Integer Programming"
rss_title = "O problema do caminho mínimo com no máximo k cores"
rss_description = "Discutiremos o problema de encontrar um caminho de custo mínimo em um grafo ponderado com coloração de arestas. Trata-se de um problema NP-difícil."
rss_pubdate = Date(2024, 08, 21)
rss_category = "algorithms"
+++

# O problema do caminho mínimo com no máximo k cores

Nesta postagem trataremos do problema que foi foco da minha dissertação de mestrado na Universidade Federal do Ceará (UFC), sob orientação do Prof. [Rafael Castro de Andrade](https://scholar.google.com/citations?hl=en&user=7gbgIFsAAAAJ&view_op=list_works&sortby=pubdate) (UFC) e co-orientação do Prof. [Rommel Dias Saraiva](https://scholar.google.com/citations?hl=en&user=HbVMz8UAAAAJ&view_op=list_works&sortby=pubdate) (Universidade de Fortaleza, UNIFOR).

O leitor interessado em mais detalhes pode conferir a [dissertação](https://repositorio.ufc.br/bitstream/riufc/73496/3/2023_dis_eescastelo.pdf) diretamente no site da UFC e o [artigo](https://www.sciencedirect.com/science/article/abs/pii/S0377221723009487) publicado no European Journal of Operational Research este ano.

Conceitos fundamentais são definidos de forma breve. Ao decorrer do texto poderão ser encontradas notas de rodapé com maiores detalhes ou referências ao que está sendo lidado no documento.

## Motivação

Embora o estudo de um problema não esteja limitado a motivações práticas, traremos luz para o exemplo abaixo para motivar aqueles mais inclinados às aplicações.

Suponha que em uma rede de telecomunicações cada tipo de conexão seja definida por uma cor distinta. Denotamos a probabiliade de falha de uma conexão do tipo $h$ por $p_{h}$. Para fins de simplicidade, assumimos $p_{h} = 1 / T$ para todo tipo de conexão $h$, onde $T$ é o total de conexões. Note que todas as conexões deste tipo falham ao mesmo tempo. Este é o caso, por exemplo, quando todas estas conexões representam cabos ethernet conectados a um determinado roteador.

Os gestores desta rede de telecomunicações desejam interligar dois pontos $A$ e $B$ da rede tal que o caminho entre eles tenha probabilidade mínima de falha. Isto é o que equivalente a dizer que o caminho entre estes pontos deve utilizar a menor quantidade de cores possível (por quê?). As cores, portanto, possuem o papel de mensurar a resiliência da rede.

Após uma reunião com os técnicos da empresa foi decidido que uma probabilidade de falha $p = k / T$ no caminho, onde $0 \leq k \leq T$, é considerada aceitável para a natureza das atividades da empresa. Em nosso cenário isto é equivalente a dizer que o caminho pode possuir no máximo $k$ cores distintas (por quê?). Por fim, a empresa também deseja minimizar o custo da rota.

O exemplo acima trata de uma possível aplicação do problema de encontrar um caminho mínimo entre um par de vértices em um grafo ponderado com coloração de arestas tal que o caminho contenha no máximo $k$ cores distintas. O leitor também pode imaginar um cenário onde cada cor codifica uma licença. O pagamento pela licença é realizada uma única vez, no momento em que a cor correspondente passa a fazer parte da solução.

Além de aplicações em redes de telecomunicações, o problema também possui aplicações na robótica[^1] e em redes de transportes[^2]. Problemas semelhantes definidos na mesma estrutura de grafos encontram suas aplicações em biologia computacional[^3].

[^1]: Eiben, E., & Kanj, I. (2020). A colored path problem and its applications. ACM Transactions on Algorithms (TALG), 16(4), 1-48.
[^2]: Dehouche, N. (2020). The k-interchange-constrained diameter of a transit network: a connectedness indicator that accounts for travel convenience. Transportation Letters, 12(3), 197-201.
[^3]: Pevzner, P. A. (1995). DNA physical mapping and alternating Eulerian cycles in colored graphs. Algorithmica, 13(1), 77-105.

## Definição

Considere a definição do problema abaixo, onde $V$ é o conjunto de vértices, $E$ o conjunto de arestas, $w: E \rightarrow \mathbb{R}_{+}$ a função de custo das arestas, e $c: E \rightarrow \mathbb{N}$ a função de coloração de arestas. Note que $k$ é um inteiro positivo.

\nameddefinition{$k$-Colour Shortest Path ou $k$-CSP}{
  Dado um grafo[^4][^5] ponderado com coloração de arestas $G = (V, E, w, c)$ e um par de vértices $s, t \in V$, o problema $k$-Colour Shortest Path consiste em obter um $st$-caminho de custo mínimo em $G$ contendo no máximo $k$ cores distintas.
}

Chamamos de *$st$-caminho* um caminho em $G$ partindo do vértice $s$ ao vértice $t$. Estes vértices são chamados de *fonte* e *sumidouro*, respectivamente.

\proposition{O $k$-Colour Shortest Path é $\mathbf{NP}$-difícil[^6][^7].}

\label{fig:exemplo_kcsp}
\begin{tikzpic}{exemplo_kcsp}
  \begin{scope}[every node/.style={draw, circle, thick}]
    \node (A) at (0, 0) {$A$};
    \node (B) at (-1.5, -1.5) {$B$};
    \node (C) at (1.5, -1.5) {$C$};
    \node (D) at (4, -1.5) {$D$};
    \node (E) at (0, -3) {$E$};
  \end{scope}

  \begin{scope}[every node/.style={circle, fill=white, text=black}]
    \draw[thick, red] (A) edge node {$1$} (B);
    \draw[thick, blue] (A) edge node {$5$} (C);
    \draw[thick, blue] (B) edge node {$1$} (E);
    \draw[thick, red] (C) edge node {$1$} (E);
    \draw[thick, green] (C) edge node {$5$} (D);
  \end{scope}
\end{tikzpic}

Observemos o exemplo dado na figura acima. Sejam $A$ e $D$ os vértices de origem e destino, respectivamente, e definamos $k = 2$ como o limite de cores. Note que o $AD$-caminho de custo mínimo é dado pela sequência $A \rightarrow B \rightarrow E \rightarrow C \rightarrow D$ de custo $8$. Todavia, este caminho utiliza três cores (vermelho, azul, e verde), portanto, não é considerado uma solução viável para o nosso problema. O leitor poderá conferir que a (única) solução ótima para nossa instância é dada pelo caminho $A \rightarrow C \rightarrow D$ de custo $10$, que utiliza duas cores distintas.

[^4]: Um exemplo de grafo ponderado pode ser visto na [figura acima](#fig:exemplo_kcsp), onde $V = \{A, B, C, D, E\}$ e $E = \{AB, AC, BE, CE, CD\}$.
[^5]: O leitor interessado poderá consultar o [material escrito](https://www.ime.usp.br/~pf/algoritmos_para_grafos/aulas/graphs.html) de [Paulo Feofiloff](https://www.ime.usp.br/~pf/) sobre definições básicas de grafos e grafos direcionados, e as [video-aulas de Teoria dos Grafos](https://www.youtube.com/watch?v=kfHqZLYHfHU&list=PLndfcZyvAqbr2MLCOLEvBNX6FgD8UNWfX) do professor [Victor Campos](https://mdcc.ufc.br/pt/corpo-docente/victor-almeida-campos/).
[^6]: Ferone, D., Festa, P., & Pastore, T. (2019). The k-color shortest path problem. Advances in Optimization and Decision Science for Society, Services and Enterprises: ODS, Genoa, Italy, September 4-7, 2019, 367-376.
[^7]: A versão de decisão do $k$-CSP pode ser visto como uma generalização da versão de decisão do problema de encontrar um caminho com quantidade mínima de cores (MCP, do inglês *Minimum Colour Path*).

## Métodos de resolução: heurísticas?

Como visto, o problema é facilmente definido. Nesta seção trataremos de uma forma de lidar com este problema e outros problemas $\mathbf{NP}$-difíceis em geral.

Um algoritmo $\mathcal{A}$ é dito ser uma *heurística* para o problema $\Pi$ se dado uma instância $I$ de $\Pi$, $\mathcal{A}(I)$ retorna uma solução viável. Perceba que não há necessariamente garantias na qualidade da solução retornada, diferentemente do que ocorre na criação de *algoritmos aproximativos*. Embora propor uma heurística seja muito dependente do problema, há algumas estratégias comumente empregadas para o design de heurísticas eficientes na prática. O leitor interessado poderá consultar as referências recomendadas[^8][^9].

Dada esta introdução, voltemos para o $k$-CSP. Como poderíamos propor uma heurística para este problema? Note que ao não nos importamos pela qualidade da solução podemos descartar a noção de que o caminho deve ter custo mínimo. Nosso objetivo é, portanto, meramente encontrar um caminho com no máximo $k$ cores distintas.

\nameddefinition{$k$-Colour Path}{
  Dado um grafo com coloração de arestas $G = (V, E, c)$ e um par de vértices $s, t \in V$, o $k$-Colour Path consiste em obter um $st$-caminho em $G$ contendo no máximo $k$ cores distintas.
}

A proposição abaixo, no entanto, apresenta-se como um obstáculo para a criação de uma heurística para este problema. O corolário segue imediatamente deste resultado.

\proposition{
  O problema de decidir se há uma solução para o $k$-Colour Path é $\mathbf{NP}$-completo[^10].
}

A implicação deste resultado é que não há um algoritmo que, em tempo $O(n^{c})$ para algum $c \geq 1$, retorne uma solução viável o nosso problema a menos que $\mathbf{P} = \mathbf{NP}$.

\corollary{
  Não há um algoritmo aproximativo em tempo polinomial para o $k$-CSP, a menos que $\mathbf{P} = \mathbf{NP}$.
}

Isto não significa que não podemos fazer algo! Em 2023, os pesquisadores Cerrone e Russo propuseram um algoritmo pseudopolynomial para o problema com complexidade de tempo $O(|L| n^{2})$ para um dado conjunto $L$ que definiremos adiante[^11]. O algoritmo, no entanto, nem sempre é capaz de retornar uma solução, e podemos facilmente construir classes de instâncias em que esse fenômeno ocorre[^12]. Aos curiosos, detalharemos o funcionamento desta heurística a seguir.

### O algoritmo de Cerrone e Russo (2023)

Ignoremos as cores atribuidas às arestas. Para a obtenção de um caminho de custo mínimo em um grafo ponderado normalmente empregaríamos o algoritmo de Dijkstra[^13], que executa em tempo $O(n^{2})$ em uma simples implementação com fila de prioridade.

E se além de levarmos em consideração o peso das arestas nós pudéssemos atribuir uma penalidade $\lambda$ a cada nova cor? A ideia é a seguinte: podemos acrescentar $\lambda$ ao custo da aresta sendo visitada se e somente se a cor desta aresta não tiver ocorrido no caminho até o momento. Esta estratégia visa "desmotivar" o algoritmo a escolher caminhos que introduzem novas cores. Cerrone e Russo (2023) definem uma lista $L$ de penalidades, e para todo $\lambda \in L$ executamos nossa modificação do algoritmo de Dijkstra.

Abaixo o leitor poderá conferir o passo-a-passo do algoritmo executado em um grafo direcionado[^14] para $k = 2$. Perceba que para $\lambda \leq 4$ a heurística retorna o caminho $s \rightarrow 3 \rightarrow 4 \rightarrow t$ como solução, embora esta não seja uma solução viável.

~~~
<figure class="blogpost_figure">
<img src="/assets/blog/solving-kcsp-problem/exemplo_heuristica_passo1.svg"/>
<figcaption><strong>Passo 1:</strong> Iniciando do vértice fonte, prosseguimos para um vértice vizinho, destacado na imagem acima. Perceba que como a cor vermelha ainda não foi utilizada para alcançar o nó de rótulo 3, nós acrescentamos a penalidade ao custo do arco.</figcaption>
</figure>

<figure class="blogpost_figure">
<img src="/assets/blog/solving-kcsp-problem/exemplo_heuristica_passo2.svg"/>
<figcaption><strong>Passo 2:</strong> Visitamos o próximo vizinho da fonte e seguimos com o mesmo raciocínio da etapa anterior.</figcaption>
</figure>

<figure class="blogpost_figure">
<img src="/assets/blog/solving-kcsp-problem/exemplo_heuristica_passo3.svg"/>
<figcaption><strong>Passo 3:</strong> Ao visitarmos o próximo vértice, percebemos que a cor azul ainda não foi utilizada, e portanto, a penalidade é adicionado ao arco. </figcaption>
</figure>

<figure class="blogpost_figure">
<img src="/assets/blog/solving-kcsp-problem/exemplo_heuristica_passo4.svg"/>
<figcaption><strong>Passo 4:</strong> O mesmo ocorre no caminho acima.</figcaption>
</figure>

<figure class="blogpost_figure">
<img src="/assets/blog/solving-kcsp-problem/exemplo_heuristica_passo5.svg"/>
<figcaption><strong>Passo 5:</strong> Seguimos com o mesmo procedimento para o arco laranja.</figcaption>
</figure>

<figure class="blogpost_figure">
<img src="/assets/blog/solving-kcsp-problem/exemplo_heuristica_passo6.svg"/>
<figcaption><strong>Passo 6:</strong> Entretanto, perceba agora que como um arco de cor vermelha já ocorre no caminho de cima, uma penalidade não será adicionada no último arco visitado.</figcaption>
</figure>
~~~

Embora o algoritmo acima nem sempre seja capaz de retornar uma solução viável, os autores obtiveram bons resultados nas instâncias propostas na literatura anterior ao nosso trabalho[^6][^11][^12][^15]. A introdução de novas heurísticas ainda é um problema em aberto.

[^8]: Talbi, E. G. (2009). Metaheuristics: from design to implementation. John Wiley & Sons.
[^9]: Mart, R., Pardalos, P. M., & Resende, M. G. (2018). Handbook of heuristics. Springer Publishing Company, Incorporated.
[^10]: Broersma, H., Li, X., Woeginger, G., & Zhang, S. (2005). Paths and cycles in colored graphs. Australasian journal of combinatorics, 31(1), 299-311.
[^11]: Cerrone, C., & Russo, D. D. (2023). An exact reduction technique for the k-Colour Shortest Path Problem. Computers & Operations Research, 149, 106027.
[^12]: Castelo, E. (2023). Contributions to the k-color shortest path problem. Master's thesis, Universidade Federal do Ceará.
[^13]: Dijkstra, E. (1959). A Note on Two Problems in Connexion with Graphs. Numerische Mathematik, 1, 269-271.
[^14]: Ao leitor que não saiba distiguir um grafo de um *grafo direcionado*, também apelidado de digrafo, basta imaginar que agora as arestas possuem direções. Neste caso, $AB$ é uma aresta direcionada do vértice $A$ ao vértice $B$. Não seria possível percorrer esta aresta na direção oposta. Arestas direcionadas são chamadas de *arcos*.
[^15]: de Andrade, R. C., Castelo, E. E. S., & Saraiva, R. D. (2024). Valid inequalities for the k-Color Shortest Path Problem. European Journal of Operational Research, 315(2), 499-510.

## Métodos de resolução: programação linear inteira

Nesta seção trataremos de como resolver problemas $\mathbf{NP}$-difíceis de forma exata em otimização combinatória ao tratarmos estes problemas como um problema de Programação Linear Inteira. Para mais informações sobre Programação Linear e Programação Linear Inteira confira as referência no rodapé[^16][^17][^18].

Antes de começarmos, construiremos uma instância equivalente representada pelo grafo direcionado ponderado com coloração de arcos $D = (V, A, w', c')$ de modo a simplificar o modelo matemático. Relembramos o leitor que recebemos como entrada o grafo ponderado com coloração de arestas $G = (V, E, w, c)$. Para toda aresta $uv \in E$ adicionaremos os arcos $uv$ e $vu$ ao conjunto $A$, onde $w'(uv) = w'(vu) = w(uv)$ e $c'(uv) = c'(vu) = c(uv)$.

\namedexample{Representação de Grafos como Grafos Direcionados}{
  Considere o grafo na figura abaixo.

  \begin{tikzpic}{exemplo_orientacao1}
    \begin{scope}[every node/.style={draw, circle, thick, fill=white}]
      \node (A) at (0, 0) {$A$};
      \node (B) at (-1.5, -1.5) {$B$};
      \node (C) at (1.5, -1.5) {$C$};
      \node (D) at (4, -1.5) {$D$};
      \node (E) at (0, -3) {$E$};
    \end{scope}

    \begin{scope}[every node/.style={circle, fill=white, text=black}]
      \draw[thick, red] (A) -- (B);
      \draw[thick, blue] (A) -- (C);
      \draw[thick, blue] (B) -- (E);
      \draw[thick, red] (C) -- (E);
      \draw[thick, green] (C) -- (D);
    \end{scope}
  \end{tikzpic}

  Para toda aresta, adicionamos dois arcos em direções opostas, obtendo o grafo direcionado abaixo.

  \begin{tikzpic}{exemplo_orientacao2}
    \begin{scope}[every node/.style={draw, circle, thick, fill=white}]
      \node (A) at (0, 0) {$A$};
      \node (B) at (-1.5, -1.5) {$B$};
      \node (C) at (1.5, -1.5) {$C$};
      \node (D) at (4, -1.5) {$D$};
      \node (E) at (0, -3) {$E$};
    \end{scope}

    \begin{scope}[every node/.style={circle, fill=white, text=black}]
      \draw[thick, red, ->] (A) edge[bend left] (B);
      \draw[thick, blue, ->] (A) edge[bend left] (C);
      \draw[thick, blue, ->] (B) edge[bend left] (E);
      \draw[thick, red, ->] (C) edge[bend left] (E);
      \draw[thick, green, ->] (C) edge[bend left] (D);

      \draw[thick, red, ->] (B) edge[bend left] (A);
      \draw[thick, blue, ->] (C) edge[bend left] (A);
      \draw[thick, blue, ->] (E) edge[bend left] (B);
      \draw[thick, red, ->] (E) edge[bend left] (C);
      \draw[thick, green, ->] (D) edge[bend left] (C);
    \end{scope}
  \end{tikzpic}

  Perceba que as cores e custos (neste exemplo toda aresta possui custo unitário) dos arcos são os mesmos da aresta na qual eles representam.
}

Note que o $k$-CSP é um problema de minimização. O primeiro passo é codificar o objetivo do problema como uma função. Lembre-se que o objetivo do $k$-CSP é encontrar um caminho de custo mínimo, portanto, definiremos as seguintes variáveis binárias para toda aresta $uv \in E$ que serão úteis logo a seguir.

$$
  x_{uv} = \begin{cases}
      1 & \text{se o arco } uv \text{ pertence à solução}, \\
      0 & \text{caso contrário.}
    \end{cases}
$$

Seguiremos com um breve abuso de notação ao definirmos $w_{uv} = w'(uv)$ como o custo do arco $uv$ para melhor visualização das equações a seguir.

$$
  \min_{x} \sum_{uv \in A} w_{uv} x_{uv}
$$

O leitor atencioso deve notar que limitar-nos apenas a minimizar a função acima não garante que os valores escolhidos definirão um caminho. De fato, podemos definir $x = \mathbf{0}^{m}$, onde $\mathbf{0}^{m}$ é um vetor $m$-dimensional de zeros e $m = |A|$ é a quantidade de arcos no digrafo. Precisamos garantir que os valores de $x$ formem um caminho. Para isto, adicionaremos o que é conhecido na literatura como *restrições de fluxo*.

Antes de continuarmos, definimos $N^{+}(u)$ para um dado vértice $u$ como a vizinhança de saída de $u$. Esta notação simboliza o conjunto de vértices tal que para todo $v \in N^{+}(u)$ temos $uv \in A$. A vizinhança de entrada $N^{-}(u)$ é definida de forma análoga. A igualdade abaixo deve ser satisfeita para todo vértice.

$$
  \sum_{v \in N^{-}(u)} x_{vu} - \sum_{v \in N^{+}(u)} x_{uv} = \begin{cases}
    -1 & \text{se } u = s, \\
    +1 & \text{se } u = t, \\
    \phantom{+}0 & \text{caso contrário}.
  \end{cases}, \quad \forall \; u \in V
$$

As desigualdades acima funcionam da seguinte maneira. Imagine as arestas do grafo como canos em uma rede hidraúlica, onde o fluxo do líquido começa na fonte $s$. Caso desejemos que o líquido chegue ao sumidouro $t$ devemos impor algumas restrições: o fluxo apenas sai da fonte; o fluxo apenas chega ao sumidouro; para toda outra interseção na rede, isto é, vértices do grafo, todo fluxo que entra também deve sair.

Agora vamos codificar o uso de cores! Definiremos a variável binária $y_{h}$ conforme descrito abaixo para toda cor $h$ existente no digrafo.

$$
  y_{h} = \begin{cases}
      1 & \text{se a cor } h \text{ pertence à solução}, \\
      0 & \text{caso contrário.}
    \end{cases}
$$

Por definição, a soma dessas variáveis deve ser menor ou igual a $k$, portanto a restrição abaixo surge naturalmente. Por simplicidade, denotaremos por $C = \{c'(uv) \mid uv \in A\}$ o conjunto de todas as cores no digrafo. Esse tipo de restrição também é conhecida como *restrição de mochila*, em referência ao Problema da Mochila[^19].

$$
  \sum_{h \in C} y_{h} \leq k
$$

Agora, precisamos garantir que utilizar um arco implique o uso de sua cor. Para isso o leitor pode derivar a desigualdade abaixo utilizando seu conhecimento de lógica[^20].

$$
  x_{uv} \leq y_{h}, \; \forall \; uv \in A \mid c'(uv) = h
$$

O nosso modelo matemático está completo! Para fácil visualização juntaremos todas as desigualdades derivadas até o momento.

$$
  \begin{align*}
    \min_{x} & \sum_{uv \in E} w_{uv} x_{uv} \\
    & \sum_{v \in N^{-}(u)} x_{vu} - \sum_{v \in N^{+}(u)} x_{uv} = \begin{cases}
      -1 & \text{se } u = s, \\
      +1 & \text{se } u = t, \\
      \phantom{+}0 & \text{caso contrário}.
    \end{cases}, \; \forall \; u \in V \\
    & \sum_{h \in C} y_{h} \leq k \\
    & x_{uv} \leq y_{h}, \; \forall \; uv \in A \mid c'(uv) = h \\
    & x_{uv} \in \{0, 1\}, \; \forall \; uv \in A \\
    & y_{h} \in \{0, 1\}, \; \forall \; h \in C
  \end{align*}
$$

O modelo acima pode ser resolvido por meio de *solvers* matemáticos como CPLEX[^21], Gurobi[^22], e até mesmo gratuitos como GLPK[^23]. O leitor pode decidir implementar estes modelos tanto diretamente em software especializado quanto em uma linguagem de programação como Python e Julia utilizando as bibliotecas adequadas[^24][^25].

Nem sempre o uso de modelos matemáticos nos possibilita resolver instâncias de tamanhos razoáveis em tempo razoável[^26]. Para isso podemos melhorar o modelo matemático acima com o uso de *desigualdades válidas*. De forma breve, desigualdades válidas são desigualdades que são satisfeitas por qualquer solução viável do problema.

Um exemplo de desigualdade válida encontra-se logo abaixo, fruto de meu trabalho de mestrado[^15]. Em palavras, essa desigualdades implica que para todos os arcos de saída de um vértice $u$ de mesma cor $h$ temos que o somatório das variáveis referentes a estes arcos é no máximo o valor da variável de decisão referente a sua cor.

$$
  \sum_{v \in N^{+}(u) \mid c(uv) = h} x_{uv} \leq y_{h}, \quad \forall \; u \in V
$$

Longe de serem as melhores apresentadas no trabalhos, entretanto, esta desigualdade em conjunto com a desigualdade análoga para arcos de entrada já produzem resultados. Exemplo disso pode ser visto com uma instância em que o modelo original descrito acima leva 615.4 segundo para obtenção do ótimo, enquanto a aplicação das desigualdades diminui esse tempo para 521.7 segundos. Outras desigualdades descritas em nosso trabalho foram capazes de diminuir esse tempo para 41.2 segundos[^15]!

[^16]: Bazaraa, M. S., Jarvis, J. J., & Sherali, H. D. (2011). Linear programming and network flows. John Wiley & Sons.
[^17]: Wolsey, L. A. (2020). Integer programming. John Wiley & Sons.
[^18]: Papadimitriou, C. H., & Steiglitz, K. (2013). Combinatorial optimization: algorithms and complexity. Courier Corporation.
[^19]: https://pt.wikipedia.org/wiki/Problema\_da\_mochila
[^20]: Busque entender o que ocorre ao escolhermos o arco $uv$.
[^21]: https://www.ibm.com/products/ilog-cplex-optimization-studio/cplex-optimizer
[^22]: https://www.gurobi.com/solutions/gurobi-optimizer/
[^23]: https://www.gnu.org/software/glpk/
[^24]: https://www.gurobi.com/resources/discover-how-you-can-boost-your-mathematical-optimization-modeling-skills-with-python/
[^25]: https://jump.dev/
[^26]: A noção de tempo e tamanho de instâncias razoáveis é relativo ao problema.
[^27]: Ferone, D., Festa, P., Fugaro, S., & Pastore, T. (2021). A dynamic programming algorithm for solving the k-color shortest path problem. Optimization Letters, 15(6), 1973-1992.

## Conclusões

Por ser um problema recente, o $k$-Colour Shortest Path ainda possui muitos problemas em aberto. Além disso, existem algoritmos de branch-and-bound[^6] e de programação dinâmica[^27] propostos na literatura na qual não descorreremos sobre por ultrapassar a restrição de que este deve ser uma postagem de blog bem informal e casual.

Sobre este último algoritmo é curioso mencionar que o mesmo possui complexidade

$$
  O\left( \left(\sum_{i=1}^{k} {|C| \choose i} \right)^{2} n\right)
$$

mas consegue, em média, resolver diversas instâncias da literatura anteriores as nossas em menos de 3 segundos[^27]. Por se tratarem de instâncias aleatórias, o estudo da complexidade de caso médio do $k$-CSP é um problema em aberto.
