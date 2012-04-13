import numpy as np

def pca(matrix):
    matrix = np.matrix(matrix)
    c_matrix = sum(matrix)/float(len(matrix))
    return np.linalg.eig(c_matrix.T * c_matrix)
    
