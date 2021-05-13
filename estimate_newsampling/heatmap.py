import numpy as np
import seaborn as sn
import matplotlib.pyplot as plt

data = [
    [1, 0.72, 0.66, 0.65, 0.64, 0.0, 0.0, 0.0],
    [2, 1.81, 1.85, 1.55, 0.0, 0.0, 0.0, 0.0],
    [3, 2.975, 2.88, 2.80, 2.66, 2.43, 2.05, 1.44],
    [4, 3.99, 3.93, 3.85, 3.74, 3.51, 3.00, 0.0],
    [5, 4.95, 4.92, 4.83, 4.694, 4.38, 3.54, 2.70],
    [6, 5.76, 5.60, 5.63, 5.53, 5.17, 0.0, 0.0],
    [7, 5.95, 5.63, 6.03, 5.28, 5.63, 0.0, 0.0],
    [8, 5.82, 5.67, 5.05, 4.27, 0.0, 0.0, 0.0],
    [9, 3.07, 2.89, 2.65, 0.0, 0.0, 0.0, 0.0],
    [9.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
]

# setting the parameter values
xticklabels = [0, 8, 16, 32, 64, 128, 256, 512]
yticklabels = [0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 0.95]

# plotting the heatmap
ax = sn.heatmap(
    data=data,
    xticklabels=xticklabels,
    yticklabels=yticklabels,
    cmap="Blues",
    # cmap="viridis",
    vmin=0.0,
    vmax=9.5,
    center=4.5,
    annot=True,
    annot_kws={"fontsize": 8},
    square=True,
    fmt=".2f",
    robust=True,
)

ax.set(
    title="Expected Error Mass",
    xlabel="k-parameter (random runs)",
    ylabel="Probability Values (prob)",
)

sn.set(font_scale=0.1)  # set fontsize 0.1

# displaying the plotted heatmap
plt.tight_layout()
plt.savefig("prob_vs_k.png", dpi=120)
