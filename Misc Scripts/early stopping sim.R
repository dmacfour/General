n <-rnorm(5,0,1)
pval <- c()

a <- c()
b <- c()


for (j in 1:10000) {
  for (i in 1:100) {
    n[i] <- rnorm(1,0,1)
    pval[i] <- t.test(n)$p.value
  }
  a[j] <- pval[100] < 0.05
  b[j] <- any(pval < 0.05)
}

sum(a)/length(a)
sum(b)/length(b)

plot(1:1000,pval,type = "l")
