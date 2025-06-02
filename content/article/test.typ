#import "/typ/templates/blog.typ": *
#show: main.with(
  title: "Test the math equation",
  desc: [Test the math equation],
  date: "2025-06-01",
  tags: (
    blog-tags.programming,
    blog-tags.typst,
  ),
)

= Raw Blocks

This is an inline raw block `class T`.

This is an inline raw block ```js class T```.

This is a long inline raw block ```js class T {}; class T {}; class T {}; class T {}; class T {}; class T {}; class T {}; class T {}; class T {};```.

Js syntax highlight are handled by syntect:

```js
class T {};
```

Typst syntax hightlight are specially handled internally:

```typ
#let f(x) = x;
```


$a in RR$

$ a in RR $



== *Setup*
- Data: $x_1, ..., x_n in RR^d$
- $K$ Gaussian components with parameters $theta = {pi_k, mu_k, Sigma_k}_(k=1)^K$
- Latent variables: $z_i in {1, 2, ..., K}$ (component assignments)

=== *Set up*
 asdfasdf


= *Model*
$ P(x_i | z_i = k, theta) = cal(N)(x_i | mu_k, Sigma_k) $
$ P(z_i = k | theta) = pi_k $

== *E-step*
Compute responsibility (posterior probability):
$ gamma_(i,k)^((t)) = P(z_i = k | x_i, theta^((t))) = (pi_k^((t)) cal(N)(x_i | mu_k^((t)), Sigma_k^((t))))/(sum_(j=1)^K pi_j^((t)) cal(N)(x_i | mu_j^((t)), Sigma_j^((t)))) $

== *M-step*
Update parameters:
$ pi_k^((t+1)) = 1/n sum_(i=1)^n gamma_(i,k)^((t)) $
$ mu_k^((t+1)) = (sum_(i=1)^n gamma_(i,k)^((t)) x_i)/(sum_(i=1)^n gamma_(i,k)^((t))) $
$ Sigma_k^((t+1)) = (sum_(i=1)^n gamma_(i,k)^((t)) (x_i - mu_k^((t+1)))(x_i - mu_k^((t+1)))^T)/(sum_(i=1)^n gamma_(i,k)^((t))) $






*Sample Data*
Positive scores: [0.9, 0.7, 0.6, 0.4] and Negative scores: [0.8, 0.5, 0.3, 0.2, 0.1]

Sorted: [(0.9,P), (0.8,N), (0.7,P), (0.6,P), (0.5,N), (0.4,P), (0.3,N), (0.2,N), (0.1,N)]

#text(size: 9pt)[
#table(
  columns: (auto, auto, auto, auto, auto, auto),
  table.header(
    [*Threshold*], [*TP*], [*FP*], [*Precision*], [*Recall*], [*F1*]
  ),
  [$t > 0.9$], [0], [0], [-], [0.00], [-],
  [$t > 0.8$], [1], [0], [1.00], [0.25], [0.40],
  [$t > 0.7$], [1], [1], [0.50], [0.25], [0.33],
  [$t > 0.6$], [2], [1], [0.67], [0.50], [0.57],
  [$t > 0.5$], [3], [1], [0.75], [0.75], [0.75],
  [$t > 0.4$], [3], [2], [0.60], [0.75], [0.67],
  [$t > 0.3$], [4], [2], [0.67], [1.00], [0.80],
  [$t > 0.2$], [4], [3], [0.57], [1.00], [0.73],
  [$t > 0.1$], [4], [4], [0.50], [1.00], [0.67],
  [$t ≤ 0.1$], [4], [5], [0.44], [1.00], [0.62],
)
]

*PR Curve Points*: (0, 1), (0.25, 1), (0.25, 0.5), (0.5, 0.67), (0.75, 0.75), (0.75, 0.6), (1, 0.67), (1, 0.57), (1, 0.5), (1, 0.44)




  #text(size: 7pt)[
  #table(
    columns: (auto, auto, auto, auto),
    table.header(
      [*Optimizer*], [*Update Rule*], [*Key Features*], [*Advantages/Disadvantages*]
    ),
    [SGD], 
    [$theta_(t+1) = theta_t - eta nabla J(theta_t)$], 
    [• Simple gradient descent\ 
     • No momentum\ 
     • Learning rate $eta$], 
    [✓ Simple, interpretable\ 
     ✓ Low memory\ 
     ✗ Slow convergence\ 
     ✗ Gets stuck in local minima],
    
    [SGD + Momentum], 
    [$v_t = gamma v_(t-1) + eta nabla J(theta_t)$\ 
     $theta_(t+1) = theta_t - v_t$\ 
     Usually $gamma = 0.9$], 
    [• Accumulates velocity\ 
     • Dampens oscillations\ 
     • Accelerates convergence], 
    [✓ Faster than vanilla SGD\ 
     ✓ Better at escaping local minima\ 
     ✓ Stable convergence\ 
     ✗ Still requires tuning $eta$],
    
   
    [AdaGrad], 
    [$G_t = G_(t-1) + (nabla J(theta_t))^2$\ 
     $theta_(t+1) = theta_t - eta/(sqrt(G_t) + epsilon) nabla J(theta_t)$], 
    [• Accumulates squared gradients\ 
     • Individual learning rates\ 
     • No decay of accumulation], 
    [✓ Good for sparse features\ 
     ✓ No manual tuning\ 
     ✗ Learning rate decays too aggressively\ 
     ✗ Stops learning eventually],
    
    [RMSprop], 
    [$v_t = gamma v_(t-1) + (1-gamma)(nabla J(theta_t))^2$\ 
     $theta_(t+1) = theta_t - eta/(sqrt(v_t) + epsilon) nabla J(theta_t)$\ 
     Usually $gamma = 0.9$], 
    [• Exponential moving average\ 
     • Fixes AdaGrad's decay\ 
     • Adaptive learning rates], 
    [✓ Fixes AdaGrad's aggressive decay\ 
     ✓ Good for non-stationary objectives\ 
     ✓ Works well with RNNs\ 
     ✗ Still needs learning rate tuning],
    

 [Adam], 
    [$m_t = beta_1 m_(t-1) + (1-beta_1) nabla J(theta_t)$\ 
     $v_t = beta_2 v_(t-1) + (1-beta_2) (nabla J(theta_t))^2$\ 
     $hat(m)_t = m_t/(1-beta_1^t)$, $hat(v)_t = v_t/(1-beta_2^t)$\ 
     $theta_(t+1) = theta_t - eta hat(m)_t/(sqrt(hat(v)_t) + epsilon)$], 
    [• Adaptive learning rates\ 
     • Bias correction\ 
     • $beta_1 = 0.9, beta_2 = 0.999$\ 
     • $epsilon = 10^(-8)$], 
    [✓ Works well out-of-the-box\ 
     ✓ Adaptive per-parameter rates\ 
     ✓ Good for sparse gradients\ 
     ✗ Can converge to suboptimal solutions\ 
     ✗ High memory usage],
    

    [AdamW], 
    [Same as Adam but:\ 
     $theta_(t+1) = (1 - eta lambda) theta_t - eta hat(m)_t/(sqrt(hat(v)_t) + epsilon)$\ 
     where $lambda$ is weight decay], 
    [• Decoupled weight decay\ 
     • Fixes Adam's L2 regularization\ 
     • Better generalization], 
    [✓ Better generalization than Adam\ 
     ✓ Proper weight decay\ 
     ✓ Good for transformers\ 
     ✗ More hyperparameters],
    
  )
  ]


