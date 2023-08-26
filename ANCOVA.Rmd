# ANALYSIS OF COVARIANCE

## **LOAD LIBRARIES**

```{r}
library(readxl)
library(tidyverse)
library(ggstatsplot)
library(onewaytests)
library(emmeans)
library(gtsummary)
library(flextable)
```

## **ATTACH DATA**

```{r}
df <- read_excel(file.choose())
attach(df)
View(df)
```

## **EXPLORATORY ANALYSIS**

```{r}
tbl_summary(df[c("BMI reduction", "Baseline BMI", "Group")], by="Group")
ggbetweenstats(data=df, x="Group", y="BMI reduction", plot.type="box")
grouped_ggscatterstats(data=df, x=`Baseline BMI`, y=`BMI reduction`, grouping.var=`Group`)
```

## **ANCOVA ASSUMPTIONS**

1.  The covariate and the treatment are independent.

    ```{r}
    summary(aov(`Baseline BMI` ~ Group))
    ```

2.  Homogeneity of variance -- we need to verify that the variances among the groups is equal

    ```{r}
    bf.test(df$`BMI reduction` ~ df$Group, data=df)
    ```

## ANALYSIS OF VARIANCE

```{r}
aov.mod <- aov(`BMI reduction` ~ Group, data=df)
summary(aov.mod)
emmeans(aov.mod, pairwise~Group)
```

## ANALYSIS OF COVARIANCE

```{r}
anc.mod <- aov(`BMI reduction` ~ Group + `Baseline BMI`, data=df)
summary(anc.mod)
emmeans(anc.mod, pairwise~Group)
```
