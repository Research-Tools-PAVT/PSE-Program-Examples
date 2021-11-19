import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


def extract_csv_gen_plot(csv_path, name, vmin, vmax):
    plt.figure(figsize=(6, 5))
    data = pd.read_csv(csv_path, index_col=0)
    data.index.names = ['ForAll Classes']
    data.columns.names = ['Probabilistic Classes']
    data = data.drop(data.columns[[0, 0]], axis=1)
    g = sns.heatmap(data, square=True, cmap="Blues",
                    annot=True,  fmt='', annot_kws={"size": 20}, vmin=vmin, vmax=vmax)
    g.set_yticklabels(g.get_yticklabels(), rotation=0, fontsize=14)
    g.set_xticklabels(g.get_xticklabels(), rotation=0, fontsize=14)
    plt.tight_layout()
    plt.savefig(name)


extract_csv_gen_plot("plot_1.csv", "coin_flips_1.pdf", vmin=30000, vmax=99000)
extract_csv_gen_plot("plot_2.csv", "coin_flips_2.pdf", vmin=9500, vmax=34000)
