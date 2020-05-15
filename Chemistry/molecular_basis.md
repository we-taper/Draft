# Molecular Hamiltonian 

Resource:

1. <https://www.youtube.com/watch?v=B3D_WZ3NbbM&t=24s>
2. <https://www.youtube.com/watch?v=vZc-PUS3ckg>

The molecular Hamiltonian in atomic units:
$$
\begin{aligned}
H &= \sum_{A} -\frac{\hbar^2}{2 M_A} \nabla_A \text{(K.E. of nuclei)} \\ 
&-\sum_i \frac{\hbar^2}{2 m_e} \nabla_i \text{(K.E. of electrons)}\\
&+ \frac{1}{2} \sum_{A,B, A\neq B} \frac{Z_A Z_B e^2}{ R_{AB}}
\text{(nuclei repulse each other)}\\
& - \sum_{i, A} \frac{Z_A e^2}{ r_{iA}} \text{(electron attracts nuclei)}\\
&+ \frac{1}{2} \sum_{i,j,i\neq j} \frac{e^2}{r_{ij}}\text{(electron repulse each other)}
\end{aligned}
$$

where $\hbar=1$, $e=1$ and $m_e=1$. $i$ are indices for electrons, $A$ are indices for nuclei. $r_{ij}$
and $r_{iA}$ represents the distance between two objects. 
$\frac{1}{2}$ accounts for multiple-counting.
Also, a lot
of constants are missing.

## Born-Oppenheimer approximation

Basically, the nuclei are assumed to be fixed
($\nabla_A=0$, nuclei repulsion is constant)
such that we only care about the electron Hamiltonian:

$$
\begin{aligned}
H_{elec} &= \sum_i \frac{\hbar^2}{2 m_e} \nabla_i \text{(K.E. of electrons)}\\
& - \sum_{i, A} \frac{Z_A e^2}{ r_{iA}} \text{(electron attracts nuclei)}\\
&+ \frac{1}{2} \sum_{i,j,i\neq j} \frac{e^2}{r_{ij}}\text{(electron repulse each other)}
\end{aligned}
$$

## Spin Orbitals
<https://www.youtube.com/watch?v=5e-JQ7z73G8>

conventions:

- orbital = $1$-electron wavefunction
- virtual = unoccupied, no electron inside the orbital.
- spatial orbitals = not just spatial, but not including spin
  - Example spatial Harmonics $Y$ in [Hydrogen](https://en.wikipedia.org/wiki/Hydrogen_atom?oldformat=true#Wavefunction)
- spin = spatial + spin

## Hartree Product
<https://www.youtube.com/watch?v=Ip7vKMHrBDo>

The wavefunction of $n$ electrons:

$$
\Psi(x_1,\cdots x_n) = \Pi_i \psi_i(x_i)
$$

where $\psi_i$ are spin orbitals of individual electrons. Problem:
- no interaction $V$
- does not correctly represent the electron's fermionic statistics.
  
## Slater determinants
<https://www.youtube.com/watch?v=EnSA3lfcFBk>

A systematic way of writing anti-symmetric wavefunctions:

$$
\Phi(x_1,\cdots, x_n) = \frac{1}{\sqrt{n!}}
\mathrm{det}\left(
    \left(\psi_i(x_j)\right)_{ij}
\right)
$$

where each $\psi_i$ are spin orbitals. Note:
1. exchange electron $\to$ exchange $\{j_1,j_2\}$ $\to$ exchange columns
2. two electron in the same spin orbital $\to$ duplicate $\psi_{i_1}=\psi_{i_2}$
   $\to$ determinant is zero.
3. For $\Phi_A$, and $\Phi_B$, each comes from a set of spin Orbitals
   $\{\psi_i\}_A$ and $\{\psi_i\}_B$, we have
   $\langle \Phi_A| \Phi_B\rangle = 0$ unless the set of spin orbitals are the same,
   in which case $\langle \Phi_A| \Phi_B\rangle = 1$.

   This is caused by $\Phi_{A/B}$ are just sum of terms like
   $\psi^{A/B}_1(x_{\sigma(1)})\cdots \psi^{A/B}_n(x_{\sigma(n)})$, and each 
   term $\phi^{A/B}_i$ is chosen from a set of orthonormal spin orbitals
   (Here $\sigma$ is not spin, but a 
   [permutation](https://en.wikipedia.org/wiki/Permutation?oldformat=true#Notations)).

