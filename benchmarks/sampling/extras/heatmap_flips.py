import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns


def extract_csv_gen_plot(csv_path, name):
    data = pd.read_csv(csv_path, index_col=0)
    data.index.names = ['ForAll Classes']
    data.columns.names = ['Probabilistic Classes']
    data = data.drop(data.columns[[0, 0]], axis=1)
    g = sns.heatmap(data, square=True, cmap="mako")
    g.set_yticklabels(g.get_yticklabels(), rotation=0)
    # g.set_title('HeatMap of frequency values for Biased Coin Flips example.')
    plt.tight_layout()
    plt.savefig(name)


# extract_csv_gen_plot1("data.csv", "coin_flips.pdf")
# extract_csv_gen_plot("data1.csv", "coin_flips_filter.pdf")

extract_csv_gen_plot("data.csv", "coin_flips_1.pdf")
