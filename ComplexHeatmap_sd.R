setwd("D:/JobManagement/工作任务/20210304001-基因组突变景观图/CMHeatmap/")


library(ComplexHeatmap)
library(circlize)

# make matrix
set.seed(123)
nr1 = 4; nr2 = 8; nr3 = 6; nr = nr1 + nr2 + nr3
nc1 = 6; nc2 = 8; nc3 = 10; nc = nc1 + nc2 + nc3
mat = cbind(rbind(matrix(rnorm(nr1*nc1, mean = 1,   sd = 0.5), nr = nr1),
          matrix(rnorm(nr2*nc1, mean = 0,   sd = 0.5), nr = nr2),
          matrix(rnorm(nr3*nc1, mean = 0,   sd = 0.5), nr = nr3)),
    rbind(matrix(rnorm(nr1*nc2, mean = 0,   sd = 0.5), nr = nr1),
          matrix(rnorm(nr2*nc2, mean = 1,   sd = 0.5), nr = nr2),
          matrix(rnorm(nr3*nc2, mean = 0,   sd = 0.5), nr = nr3)),
    rbind(matrix(rnorm(nr1*nc3, mean = 0.5, sd = 0.5), nr = nr1),
          matrix(rnorm(nr2*nc3, mean = 0.5, sd = 0.5), nr = nr2),
          matrix(rnorm(nr3*nc3, mean = 1,   sd = 0.5), nr = nr3))
   )
mat = mat[sample(nr, nr), sample(nc, nc)] # random shuffle rows and columns
rownames(mat) = paste0("row", seq_len(nr))
colnames(mat) = paste0("column", seq_len(nc))

# color for continuous value
col_fun <- colorRamp2(breaks = c(-2, 0, 2), colors = c("green", "white", "red"))
Heatmap(mat, col = col_fun, column_title = "colorRamp2")

# color for discrete value
# colors should be specified as a named vector
discrete_mat = matrix(sample(1:4, 100, replace = TRUE), 10, 10)
colors <- c("1"="black", "2"="red", "3"="green", "4"="blue")
Heatmap(discrete_mat, col = colors, name = "Discrete")

# color for NA value
mat_with_na = mat
na_index = sample(c(TRUE, FALSE), nrow(mat)*ncol(mat), replace = TRUE, prob = c(1, 9))
mat_with_na[na_index] = NA
Heatmap(mat_with_na, name = "mat", na_col = "black", column_title = "a matrix with NA values")

# 热图边界颜色
# 1. 全局边界颜色：指的是整个热图的边间，由参数 border，可以是逻辑值，或者颜色字符串
# 2. 单元格颜色：指的是热图中每一个 cell 的颜色，由参数 rect_gp，是一种 gpar 对象
Heatmap(mat, name = "mat", border = c(col = "black", lty = 2), column_title = "set heatmap border")

Heatmap(mat, name = "mat", rect_gp = gpar(col = "white"), column_title = "cell color")

# ------------------------------------- #
# 热图的标题
# 1. 列标题：column_title
# 2. 行标题：row_title
# 3. 标题的位置： column_title_side 和 row_title_side
Heatmap(mat, name = "mat", column_title = "i am a column title", row_title = "i am a row title",
        column_title_side = "bottom", row_title_side = "right")
# 4. 标题参数设置
# row_title_gp 和 column_title_gp 参数设置，他们是gpar对象
Heatmap(mat, name = "mat",
        column_title = "i an a column title",
        column_title_side = "bottom",
        column_title_gp = gpar(col="red", fontsize = 18, fontface="bold"))
# 5. 支持分割的标题
# code only for demonstration
# row title would be cluster_1 and cluster_2
Heatmap(mat, name = "mat", row_km = 2, row_title = "cluster_%s")
