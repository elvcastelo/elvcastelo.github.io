Há atualmente uma quantidade gigantesca de conteúdos sobre ciência da computação em inglês na internet, desde [materiais para competições](https://cp-algorithms.com/graph/bridge-searching.html) até [notas de aulas de professores de universidades estrangeiras](https://faculty.etsu.edu/gardnerr/5340/notes-Bondy-Murty-GT/Bondy-Murty-GT-10-4.pdf).
Infelizmente não podemos dizer o mesmo quanto à quantidade de materiais em português **[...]**

# Definições básicas

Começaremos com um breve dilema. Não sobre o conteúdo da postagem mas sobre a forma como é escrito.
A todo momento iremos assumir que o leitor está familiarizado com noções básicas de teoria dos grafos — o que talvez não faça sentido em uma postagem sobre pontes!

Pois bem, a razão é que apresentar toda essa introdução à teoria dos grafos é (i) chato, (ii) desnecessário, visto que há vários conteúdos introdutórios, mesmo em português, circulando pela internet, e (iii) nos afasta do assunto.
Tentaremos trazer um equilibrio com figuras bonitas, para que o leitor tenha algo para ver enquanto se perde (ou bons exemplos enquanto se encontra).

Seja $G$ um grafo conexo.
Uma *ponte* é uma aresta $xy$ tal que $G - xy$ é desconexo, isto é, $G - xy$ possui ao menos duas componentes conexas.

# Exemplos

# Listando todas as pontes

Considere o problema de listar todas as pontes de um grafo $G$.

## O algoritmo trivial

Considere o seguinte algoritmo. Para toda aresta $xy \in E(G)$ verificamos se existe um par $a, b \in V(G)$ tal que $dist(a, b) = \infty$ em $G - xy$.
Caso a resposta seja positiva, exibimos $xy$ e prosseguimos para a aresta seguinte.
Caso contrário, concluimos que $xy$ não é uma ponte e prosseguimos para a aresta seguinte.

A corretude desse algoritmo segue diretamente da definição de ponte em grafos.
É fácil ao fim listamos todas as pontes em tempo $O(n^{3}m + n^{2}m^{2})$[^1].

[^1]: O grafo $G$ contém $n$ vértices e $m$ arestas. Por fim, um $x$-$y$ caminho pode ser obtido em tempo $O(n + m)$.

## Um pequeno detalhe

Observe que se a aresta $xy$ é uma ponte de $G$, então não existe um ciclo que a contém. Portanto, podemos listar todas as pontes de $G$ utilizando o seguinte algoritmo: para toda aresta $xy$ de $G$ remova 

$O(nm + m^{2})$.

## Um pouco mais de atenção aos detalhes

$O(n + m)$

# Teorema de Dilworth

# Teorema de Robbins

# Algoritmo de Fleury

# Aplicações