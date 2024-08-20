+++
title = "O problema do caminho mínimo com no máximo k cores"
description = "Discutiremos o problema de encontrar um caminho de custo mínimo em um grafo ponderado com coloração de arestas. Trata-se de um problema NP-difícil."
+++
# O problema do caminho mínimo com no máximo k cores

Nesta postagem trataremos do problema que foi foco da minha dissertação de mestrado na Universidade Federal do Ceará (UFC), sob orientação do Prof. [Rafael Castro de Andrade](https://scholar.google.com/citations?hl=en&user=7gbgIFsAAAAJ&view_op=list_works&sortby=pubdate) (UFC) e co-orientação do Prof. [Rommel Dias Saraiva](https://scholar.google.com/citations?hl=en&user=HbVMz8UAAAAJ&view_op=list_works&sortby=pubdate) (Universidade de Fortaleza, UNIFOR).

O leitor interessado em mais detalhes pode conferir a [dissertação](https://repositorio.ufc.br/bitstream/riufc/73496/3/2023_dis_eescastelo.pdf) diretamente no site da UFC e o [artigo](https://www.sciencedirect.com/science/article/abs/pii/S0377221723009487) publicado no European Journal of Operational Research este ano.

## Motivação

Embora o estudo de um problema não esteja limitado a motivações práticas, traremos luz para o exemplo abaixo para motivar aqueles mais inclinados às aplicações.

Suponha que em uma rede de telecomunicações cada tipo de conexão seja definida por uma cor distinta. Ainda, cada tipo de conexão $h$ possui uma probabilidade $p_{h}$ de falhar. Para fins de simplicidade, definiremos $p_{h} = 1 / T$ para todo tipo de conexão $h$, onde $T$ é o total de conexões.

Caso os gestores desta rede de telecomunicações desejem interligar dois pontos $A$ e $B$ da rede tal que o caminho entre eles tenha probabilidade mínima de falha, devemos ter, portanto, que o caminho entre estes pontos deve utilizar a menor quantidade de cores possível (por quê?). As cores, portanto, possuem o papel de mensurar a resiliência da rede.

Assumamos que após uma reunião com os técnicos da empresa foi decidido que uma probabilidade $k / T$ de falha, onde $0 \leq k \leq T$, é considerada aceitável para a natureza das atividades da empresa. Perceba que no nosso cenário isto é equivalente a dizer que o caminho pode possuir no máximo $k$ cores distintas. Em adição, a empresa pode decidir preferência pelas rotas de menor custo.

O exemplo acima trata de uma possível aplicação do problema de encontrar um caminho mínimo entre um par de vértices em um grafo ponderado com coloração de arestas tal que o caminho contenha no máximo $k$ cores distintas. Além de aplicações em redes de telecomunicações, o problema também possui aplicações na robótica[^1] e em redes de transportes[^2]. Problemas semelhantes definidos na mesma estrutura de grafos encontram suas aplicações em biologia computacional[^3].

[^1]: Eiben, E., & Kanj, I. (2020). A colored path problem and its applications. ACM Transactions on Algorithms (TALG), 16(4), 1-48.
[^2]: Dehouche, N. (2020). The k-interchange-constrained diameter of a transit network: a connectedness indicator that accounts for travel convenience. Transportation Letters, 12(3), 197-201.
[^3]: Pevzner, P. A. (1995). DNA physical mapping and alternating Eulerian cycles in colored graphs. Algorithmica, 13(1), 77-105.

## Definição

Considere a definição do problema abaixo, onde $V$ é o conjunto de vértices, $E$ o conjunto de arestas, $w: E \rightarrow \mathbb{R}_{+}$ a função de custo das arestas, e $c: E \rightarrow \mathbb{N}$ a função de coloração de arestas. Note que $k$ é um inteiro positivo.

\nameddefinition{$k$-Colour Shortest Path ou $k$-CSP}{
  Dado um grafo[^4][^5] ponderado com coloração de arestas $G = (V, E, w, c)$ e um par de vértices $s, t \in V$, o problema $k$-Colour Shortest Path consiste em obter um $st$-caminho de custo mínimo em $G$ contendo no máximo $k$ cores distintas.
}

Chamados de $st$-caminho um caminho em $G$ partindo do vértice $s$ ao vértice $t$. Estes vértices são chamados de fonte e sumidouro, respectivamente.

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

Observemos o exemplo dado na figura acima. Sejam $A$ e $D$ os vértices de origem e destino, respectivamente, e definamos $k = 2$ como o limite de cores. Note que o $AD$-caminho de custo mínimo é dado pela sequência $A \rightarrow B \rightarrow E \rightarrow C \rightarrow D$ de custo $8$. Todavia, este caminho utiliza três cores (vermelho, azul, e verde), portanto, não é considerado uma solução viável para o nosso problema. O leitor poderá conferir que a (única) solução ótima para nossa instância é dada pelo caminho $A \rightarrow C \rightarrow D$ de custo $10$ que utiliza duas cores distintas.

[^4]: Um exemplo de grafo ponderado pode ser visto na [figura acima](#fig:exemplo_kcsp), onde $V = \{A, B, C, D, E\}$ e $E = \{AB, AC, BE, CE, CD\}$.
[^5]: O leitor interessado poderá consultar o [material escrito](https://www.ime.usp.br/~pf/algoritmos_para_grafos/aulas/graphs.html) de [Paulo Feofiloff](https://www.ime.usp.br/~pf/) sobre definições básicas de grafos e grafos direcionados, e as [video-aulas de Teoria dos Grafos](https://www.youtube.com/watch?v=kfHqZLYHfHU&list=PLndfcZyvAqbr2MLCOLEvBNX6FgD8UNWfX) do professor [Victor Campos](https://mdcc.ufc.br/pt/corpo-docente/victor-almeida-campos/).
[^6]: Ferone, D., Festa, P., & Pastore, T. (2019). The k-color shortest path problem. Advances in Optimization and Decision Science for Society, Services and Enterprises: ODS, Genoa, Italy, September 4-7, 2019, 367-376.
[^7]: A versão de decisão do $k$-CSP pode ser visto como uma generalização da versão de decisão do problema de encontrar um caminho com quantidade mínima de cores (MCP, do inglês *Minimum Colour Path*).

## Métodos de resolução: heurísticas?

Definimos brevemente uma heurística como um algoritmo que retorna uma solução viável para o problema em questão. Perceba que não impomos qualquer restrição na qualidade da solução, diferentemente do que ocorre na criação de algoritmos aproximativos. Embora propor uma heurística seja muito dependente do problema, há algumas estratégias comumente empregadas para o design de heurísticas eficientes na prática. O leitor interessado poderá consultar as referências recomendadas[^8][^9].

Dada esta introdução, voltemos para o $k$-CSP. Como poderíamos propor uma heurística para este problema? Note que ao não nos importamos pela qualidade da solução podemos descartar a noção de que o caminho deve ter custo mínimo. Nosso objetivo é, portanto, meramente encontrar um caminho com no máximo $k$ cores distintas.

\nameddefinition{$k$-Colour Path}{
  Dado um grafo com coloração de arestas $G = (V, E, c)$ e um par de vértices $s, t \in V$, o $k$-Colour Path consiste em obter um $st$-caminho em $G$ contendo no máximo $k$ cores distintas.
}

A proposição abaixo, no entanto, apresenta-se como um obstáculo para a criação de uma heurística para este problema.

\proposition{
  O problema de decidir se há uma solução para o $k$-Colour Path é $\mathbf{NP}$-completo[^10].
}

A implicação deste resultado é que não há um algoritmo que, em tempo $O(n^{c})$ para algum $c \geq 1$, retorne uma solução viável o nosso problema a menos que $\mathbf{P} = \mathbf{NP}$.

Isto não significa que não podemos fazer algo! Em 2023, os pesquisadores Cerrone e Russo propuseram um algoritmo pseudopolynomial para o problema com complexidade de tempo $O(|L| n^{2})$ para um dado conjunto $L$ que definiremos adiante[^11]. O algoritmo, no entanto, nem sempre é capaz de retornar uma solução, e podemos facilmente construir classes de instâncias em que esse fenômeno ocorre[^12]. Aos curiosos, detalharemos o funcionamento desta heurística a seguir.

### O algoritmo de Cerrone e Russo (2023)

Ignorando as cores atribuidas às arestas, para a obtenção de um caminho mínimo em um grafo ponderado normalmente empregaríamos o algoritmo de Dijkstra[^13], que executa em tempo $O(n^{2})$ em uma simples implementação com fila de prioridade.

E se além de levarmos em consideração o peso das arestas nós pudéssemos atribuir uma penalidade $\lambda$? A ideia é a seguinte: podemos acrescentar $\lambda$ ao custo da aresta sendo visitada se e somente se a cor desta aresta não tiver ocorrido no caminho até o momento. Esta estratégia visa "desmotivar" o algoritmo a escolher caminhos que introduzem novas cores. Cerrone e Russo (2023) definem uma lista $L$ de penalidades, e para todo $\lambda \in L$ executamos o algoritmo de Dijkstra modificado acima.

Abaixo o leitor poderá conferir o passo-a-passo do algoritmo executado em um grafo direcionado[^14] com $k = 2$. Note que para $\lambda \leq 4$ a heurística retorna o caminho $s \rightarrow 3 \rightarrow 4 \rightarrow t$ como solução, embora esta não seja uma solução viável.

~~~
<figure class="blogpost_figure">
<img src="/assets/blog/solving-np-hard-kcsp/index/exemplo_heuristica_passo1.svg"/>
<figcaption><strong>Passo 1:</strong> Iniciando do vértice fonte, prosseguimos para um vértice vizinho, destacado na imagem acima. Perceba que como a cor vermelha ainda não foi utilizada para alcançar o nó de rótulo 3, nós acrescentamos a penalidade ao custo do arco.</figcaption>
</figure>

<figure class="blogpost_figure">
<img src="/assets/blog/solving-np-hard-kcsp/index/exemplo_heuristica_passo2.svg"/>
<figcaption><strong>Passo 2:</strong> Visitamos o próximo vizinho do vértice fonte. Seguimos com o mesmo raciocínio da etapa anterior.</figcaption>
</figure>

<figure class="blogpost_figure">
<img src="/assets/blog/solving-np-hard-kcsp/index/exemplo_heuristica_passo3.svg"/>
<figcaption><strong>Passo 3:</strong> Seguindo esta lógica, a cor azul ainda não foi utilizada, e portanto, uma penalidade é adicionado ao arco. </figcaption>
</figure>

<figure class="blogpost_figure">
<img src="/assets/blog/solving-np-hard-kcsp/index/exemplo_heuristica_passo4.svg"/>
<figcaption><strong>Passo 4:</strong> O mesmo é verdade para o caminho que construímos logo acima.</figcaption>
</figure>

<figure class="blogpost_figure">
<img src="/assets/blog/solving-np-hard-kcsp/index/exemplo_heuristica_passo5.svg"/>
<figcaption><strong>Passo 5:</strong> Seguimos com o mesmo procedimento para o arco laranja.</figcaption>
</figure>

<figure class="blogpost_figure">
<img src="/assets/blog/solving-np-hard-kcsp/index/exemplo_heuristica_passo6.svg"/>
<figcaption><strong>Passo 6:</strong> Entretanto, perceba que como um arco de cor vermelha já ocorre no caminho de cima, uma penalidade não será adicionada no último arco.</figcaption>
</figure>
~~~

Embora o algoritmo acima nem sempre seja capaz de retornar uma solução viável, os autores obtiveram bons resultados nas instâncias propostas na literatura anterior ao nosso trabalho[^6][^11][^12][^15].

[^8]: Talbi, E. G. (2009). Metaheuristics: from design to implementation. John Wiley & Sons.
[^9]: Mart, R., Pardalos, P. M., & Resende, M. G. (2018). Handbook of heuristics. Springer Publishing Company, Incorporated.
[^10]: Broersma, H., Li, X., Woeginger, G., & Zhang, S. (2005). Paths and cycles in colored graphs. Australasian journal of combinatorics, 31(1), 299-311.
[^11]: Cerrone, C., & Russo, D. D. (2023). An exact reduction technique for the k-Colour Shortest Path Problem. Computers & Operations Research, 149, 106027.
[^12]: Castelo, E. (2023). Contributions to the k-color shortest path problem. Master's thesis, Universidade Federal do Ceará.
[^13]: Dijkstra, E. (1959). A Note on Two Problems in Connexion with Graphs. Numerische Mathematik, 1, 269-271.
[^14]: Ao leitor que não saiba distiguir um grafo de um *grafo direcionado*, também apelidado de digrafo, basta imaginar que agora as arestas possuem direções. Neste caso, $AB$ é uma aresta direcionada do vértice $A$ ao vértice $B$. Não seria possível percorrer esta aresta na direção oposta. Arestas direcionadas são chamadas de *arcos*.
[^15]: de Andrade, R. C., Castelo, E. E. S., & Saraiva, R. D. (2024). Valid inequalities for the k-Color Shortest Path Problem. European Journal of Operational Research, 315(2), 499-510.

## Métodos de resolução: programação linear inteira

Nesta seção trataremos de como resolver problemas $\mathbf{NP}$-difíceis em otimização combinatória ao tratarmos estes problemas como um problema de Programação Linear Inteira. Para mais informações sobre Programação Linear e Programação Linear Inteira confira as referência no rodapé[^16][^17][^18].

Antes de começarmos, definiremos uma instância caracterizada pelo grafo direcionado $D$ equivalente ao nosso problema. A construção deste digrafo é feita pela orientação das arestas de $G$. Isto significa que para toda aresta $uv$ em $G$ nós adicionaremos os arcos $uv$ e $vu$ ao digrafo $D$, mantendo propriedades como cores e custos. O motivo para esta transformação ficará mais clara adiante.

\namedexample{Orientação de Grafos}{
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
}

Note que o $k$-CSP é um problema de minimização. O primeiro passo é codificar o objetivo do problema como uma função. Lembre-se que o objetivo do $k$-CSP é encontrar um caminho de custo mínimo, portanto, definiremos as seguintes variáveis binárias para toda aresta $uv \in E$ que serão úteis logo a seguir.

$$
  x_{uv} = \begin{cases}
      1 & \text{se o arco } uv \text{ pertence à solução}, \\
      0 & \text{caso contrário.}
    \end{cases}
$$

Seguiremos com um breve abuso de notação ao definirmos $w_{uv} = w(uv)$ como o custo da aresta $uv$ para melhor visualização das equações a seguir.

$$
  \min_{x} \sum_{uv \in E} w_{uv} x_{uv}
$$

O leitor atencioso deve notar que limitar-nos apenas a minimizar a função acima não garante que os valores escolhidos definirão um caminho. De fato, podemos definir $x = \mathbf{0}^{m}$, onde $\mathbf{0}^{m}$ é um vetor $m$-dimensional de zeros e $m = |E|$ é a quantidade de arestas do grafo. Precisamos garantir que os valores de $x$ formem um caminho. Para isto, adicionaremos o que é conhecido na literatura como *restrições de fluxo*.

Antes de mostrarmos essas restrições, definimos $N^{+}(u)$ (resp. $N^{-}(u)$) para um dado vértice $u$ como a vizinhança de saída (resp. entrada) de $u$. Esta notação simboliza o conjunto de vértices $v$ tal que $uv$ (resp. $vu$) seja um arco do grafo direcionado. A igualdade abaixo deve ser satisfeita para todo vértice.

$$
  \sum_{v \in N^{-}(u)} x_{vu} - \sum_{v \in N^{+}(u)} x_{uv} = \begin{cases}
    -1 & \text{se } u = s, \\
    +1 & \text{se } u = t, \\
    \phantom{+}0 & \text{caso contrário}.
  \end{cases}
$$

As desigualdades acima funciona da seguinte maneira. Imagine as arestas do grafo como canos em uma rede hidraúlica, onde o fluxo do líquido começa na fonte $s$. Caso desejemos que o líquido chegue ao sumidouro $t$, então devemos algumas restrições: o fluxo só pode sair da nossa fonte, nunca entrar; o fluxo deve apenas chegar ao sumidouro, nunca sair; para toda outra interseção na rede, isto é, vértices do grafo, tudo que entra também deve sair.

Agora vamos codificar o uso de cores! Definiremos a variável binária $y_{h}$ logo abaixo para toda cor $h$ existente no digrafo.

$$
  y_{h} = \begin{cases}
      1 & \text{se a cor } h \text{ pertence à solução}, \\
      0 & \text{caso contrário.}
    \end{cases}
$$

Por definição, a soma dessas variáveis deve ser menor ou igual a $k$, portanto a restrição abaixo surge naturalmente. Por simplicidade, denotaremos por $C$ o conjunto de todas as cores. Esse tipo de restrição também é conhecida como *restrição de mochila*, em referência ao Problema da Mochila[^19].

$$
  \sum_{h \in C} y_{h} \leq k
$$

Agora, precisamos garantir que utilizar um arco implique o uso de sua cor. Para isso o leitor pode derivar a desigualdade abaixo utilizando seu conhecimento de lógica[^20].

$$
  x_{uv} \leq y_{h}, \; \text{se } c(uv) = h
$$

O nosso modelo matemático está completo! Para fácil visualização juntaremos todas as desigualdades derivadas até o momento em uma só equação. Denotaremos por $A$ o conjunto de arcos do grafo direcionado.

$$
  \begin{align*}
    \min_{x} & \sum_{uv \in E} w_{uv} x_{uv} \\
    & \sum_{v \in N^{-}(u)} x_{vu} - \sum_{v \in N^{+}(u)} x_{uv} = \begin{cases}
      -1 & \text{se } u = s, \\
      +1 & \text{se } u = t, \\
      \phantom{+}0 & \text{caso contrário}.
    \end{cases}, \; \forall \; u \in V \\
    & \sum_{h \in C} y_{h} \leq k \\
    & x_{uv} \leq y_{h}, \; \forall \; uv \in A \\
    & x_{uv} \in \{0, 1\}, \; \forall \; uv \in A \\
    & y_{h} \in \{0, 1\}, \; \forall \; h \in C
  \end{align*}
$$

O modelo acima pode ser resolvido por meio de *solvers* matemáticos como CPLEX[^21], Gurobi[^22], e até mesmo gratuitos como GLPK[^23]. O leitor pode decidir implementar estes modelos tanto diretamente em software especializado quanto em uma linguagem de programação como Python e Julia utilizando as bibliotecas adequadas[^24][^25].

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
