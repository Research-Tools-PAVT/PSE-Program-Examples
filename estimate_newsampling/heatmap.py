import numpy as np
import seaborn as sn
import matplotlib.pyplot as plt

data = [
    [0.7288, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
    [1.815, 1.855, 1.55, 0.0, 0.0, 0.0, 0.0],
    [2.975, 2.88, 0.0, 0.0, 0.0, 2.05, 0.0],
    [3.90, 0.0, 0.0, 0.0, 3.16, 3.004, 0.0],
    [4.95, 4.92, 4.83, 4.694, 4.38, 3.54, 2.70],
    [5.76, 5.60, 5.63, 5.53, 0.0, 0.0, 0.0],
    [5.95, 0.0, 6.07, 0.0, 0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
    [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0],
]

# setting the parameter values
xticklabels = [8, 16, 32, 64, 128, 256, 512]
yticklabels = [0.10, 0.20, 0.30, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 0.95]

# plotting the heatmap
ax = sn.heatmap(
    data=data,
    xticklabels=xticklabels,
    yticklabels=yticklabels,
    cmap="Blues",
    # cmap="viridis",
    vmin=0.0,
    vmax=6.5,
    center=3.0,
    annot=True,
    annot_kws={"fontsize": 8},
    square=True,
    fmt=".2f",
    robust=False,
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
