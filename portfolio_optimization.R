library(linprog)

#Current ROI Assumptions (ROI != ROAS)
roi.sem.brand = 0.30 #30%
roi.sem.nonbrand = 0.70 #70%
roi.seo = 0.10 #10%
roi.tv = 0.01 #1%
roi.social = 0.02 #2%
roi.display = 0.01 #1%

#Requirements & Constraints
max.spend.total.marketing = 10000000 #$6M

min.spend.sem.brand = 500000 #$500k
max.spend.sem.brand = 3000000 #$3M

min.spend.sem.nonbrand = 500000 #$500k
max.spend.sem.nonbrand = 6000000 #$6M

min.spend.seo = 100000 #$100k
max.spend.seo = 300000 #$300k

min.spend.tv = 1500000 #$1.5M
max.spend.tv = 3000000 #$3M

min.spend.social = 100000 #$100k
max.spend.social = 500000 #$500k

min.spend.display = 300000 #$300k
max.spend.display = 1000000 #$1M

max.reach = 500000000 #75 million people

#min.digital.spend = 40% of budget (includes sem, seo, display)
min.digital.spend = 0.4


#Unique impressions per dollar spent (people)
reach.sem.brand = 100
reach.sem.nonbrand = 65
reach.seo = 200
reach.tv = 500
reach.social = 300
reach.display = 600

#Maximization and Optimization
MAXIMIZATION.ROI = c(roi.sem.brand,
                     roi.sem.nonbrand,
                     roi.seo,
                     roi.tv,
                     roi.social,
                     roi.display)

#Variable Order = c(sem.brand,sem.nonbrand,seo,tv,social,display)
DECISIONS = rbind(
  c(1,1,1,1,1,1),
  c(-1,0,0,0,0,0),
  c(1,0,0,0,0,0),
  c(0,-1,0,0,0,0),
  c(0,1,0,0,0,0),
  c(0,0,-1,0,0,0),
  c(0,0,1,0,0,0),
  c(0,0,0,-1,0,0),
  c(0,0,0,1,0,0),
  c(0,0,0,0,-1,0),
  c(0,0,0,0,1,0),
  c(0,0,0,0,0,-1),
  c(0,0,0,0,0,1),
  c(-1*min.digital.spend,-1*min.digital.spend,-1*min.digital.spend,min.digital.spend,min.digital.spend,-1*min.digital.spend),
  c(reach.sem.brand,reach.sem.nonbrand,reach.seo,reach.tv,reach.social,reach.display)
)

#Constraints (negative = min.values)
CONSTRAINTS = c(max.spend.total.marketing,
                -1*min.spend.sem.brand,
                max.spend.sem.brand,
                -1*min.spend.sem.nonbrand,
                max.spend.sem.nonbrand,
                -1*min.spend.seo,
                max.spend.seo,
                -1*min.spend.tv,
                max.spend.tv,
                -1*min.spend.social,
                max.spend.social,
                -1*min.spend.display,
                max.spend.display,
                0,
                max.reach)

solveLP(MAXIMIZATION.ROI,CONSTRAINTS,DECISIONS,maximum=TRUE)
