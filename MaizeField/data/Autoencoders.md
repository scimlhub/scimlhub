# Autoencoders

### <span style=color:lightblue>1. Introduction: The Need for Compact Representations</span>
Real-world data like images, audio, sensor readings, all exists in extremely high dimensional spaces. A single MNIST image is a vector of `28x28` pixel values. A color photo from a modern camera can have millions of dimensions. Yet, the intrinsic information in that data often lives in a much lower-dimensional space. An image of a handwritten digit can be described by a handful of parameters: stroke width, slant, curvature.

This gap between ambient dimensionality and intrinsic dimensionality motivates the entire field of dimensionality reduction. Two powerful families of methods have emerged: **classical linear methods like PCA**, and **non-linear neural methods like Autoencoders**. 

---
### <span style=color:lightblue> 2. Principle Component Analysis </span>
PCA is the classic linear approach to dimensionality reduction.

How PCA works :
	• Centre the data : subtract the mean from each feature.
	• Compute the covariance matrix.
	• Eigen decomposition : find eigenvectors and eigenvalues of the matrix.
	• Select top-k eigenvectors (principal components) by largest eigenvalue. 
	• Project the data: Z = X · W, where W are the top-k eigenvectors

---

### <span style=color:lightblue> 3. Autoencoders: Neural Network Compression </span>
Autoencoder is a neural network trained to compress data into a low dimensional latent representation, and then reconstruct the original data from it. 

![](attachments/Pasted%20image%2020260307181554.png)

The **Encoder** converts the high dimensional input into low dimensional latent space. The **Decoder** than reconstruct it back to the original dimension. The network is trained to minimize this reconstruction loss.

>With linear activations, an Autoencoder with one hidden layer is mathematically equivalent to PCA — it finds the same subspace. With non-linear activations (ReLU, sigmoid, tanh), an Autoencoder can model complex non-linear manifolds, making it far more powerful.

---

### <span style=color:lightblue>4. Autoencoder Use Cases</span>
#### <span style=color:lightblue>4.1 Denoising Autoencoder</span>
A Denoising Autoencoder corrupts the input with noise and trains the network to reconstruct the original clean input. This forces the encoder to learn robust, noise-invariant features rather than trivially memorizing the input

**Use Cases**: Image denoising, audio cleaning, robust feature learning, pre-training.

![](attachments/Pasted%20image%2020260307183230.png)

#### <span style=color:lightblue>4.2 Anamoly Detection with Autoencoder</span>
Autoencoders trained on normal data learn to reconstruct normal patterns well. When presented with an anomalous input, the reconstruction error is high, the model has no compact representation for something outside its training distribution. **This reconstruction error acts as an anomaly score**.

**Use Cases**: Fraud detection, network intrusion detection, manufacturing defect detection, medical diagnosis.

---

### <span style=color:lightblue>5. Variational Autoencoder (VAE)</span>
The standard Autoencoder learns a compressed code but the latent space has no guaranteed structure, it can have holes, discontinuities, and arbitrary topology. We cannot simply sample a random point in latent space and expect a meaningful decoded output.

The Variational Autoencoder solves this by forcing the latent space to follow a known prior distribution. Instead of encoding x (input) to a single point z (latent field), the encoder outputs the parameters of a Gaussian: mean µ and standard deviation σ

**VAE Loss Function** : It has two losses , i. e, **Reconstruction Loss** which is same as autoencoder.
$$
Lrecon​=∣∣x−x^∣∣
$$
The KL Divergence Loss which forces latent distribution to match Gaussian prior:
$$
LKL​=−21​∑(1+log(σ2)−μ2−σ2)
$$
Hence Total Loss becomes:
$$
L=Lrecon​+LKL​
$$
This is what makes the latent space smooth.

**Use Cases** : Image generation, speech synthesis, 3D shape generation.