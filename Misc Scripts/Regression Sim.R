#Simple interaction

s <- 10
n <- 200

m <- 2
b <- 0
x <- runif(n,-10,10)
y <- rnorm(n,m*x + b, sd = s)

m1 <- 6
b1 <- 10
x1<- runif(n,-10,10)
y1 <- rnorm(n,m1*x + b1, sd = s)

dat <- rbind(data.frame(x = cbind(x),y = cbind(y), d = 1),
data.frame(x = x,y = y1, d = 2))

plot(dat$x,dat$y)
summary(lm(y ~ x*as.factor(d), data = dat))

#Continuous Interaction
pv <- c()

for(i in 1:100){
  s <- 5
  n <- 520
  
  b0 <- 2
  b <- 0
  b2 <- 0
  b3 <- 0
  x <- runif(n,10,20)
  x2 <- runif(n,10,20)
  
  #y <- rnorm(n, b0 + b*x + b2*x2 + b3*x*x2, sd = s)
  #y <- rcauchy(n = n,location = b0 + b*x + b2*x2 + b3*x*x2, scale = s)
  y <- rpois(n = n,lambda = b0 + b*x + b2*x2 + b3*x*x2)
  plot(x,y)
  mod <- lm(y ~ x * x2)
  
  pv[i] <- glance(mod)$p.value < 0.05
}

sum(pv)/length(pv)

mod
summary(mod)
