from pathlib import Path
import os
import math
from collections import namedtuple
from typing import List


class Subfig:
    """
    Creates a subfig environment containing many figures added to this package
    """
    TEMPLATE = r"""\begin{figure}%
__ALIGNMENT__
__SUBFIGS__

\caption{__CAPTION__}
\label{fig:__LABEL__}
\end{figure}
"""
    SINGLE_FIG = r"""\subfloat[__LIST_ENTRY__][__SUB_CAPTION__]{
    \label{fig:__SUB_LABEL__}%
    \includegraphics[__INC_OPTION__]{__FIGPATH__}
}
""" # todo width
    Fig = namedtuple('fig', ['figpath', 'list_entry', 'sub_caption','sub_label','inc_option'])

    def __init__(self, caption, alignment = 'left', label=None):
        """

        :param caption: The caption for every subfig in this environment
        """
        self.caption = caption
        if label is None: self.label = caption
        else: self.label = label
        if alignment == 'left':
            self.alignment = ''
        elif alignment == 'center':
            self.alignment = '\\centering'
        else:
            raise ValueError(alignment)

        self.figs = []

    def add_fig(self, figpath: str,
                sub_caption = '', sub_label = None, list_entry = '',
                include_option = ''):
        if Path(figpath).exists(): pass
        else: print('"' + figpath + '" not found (may not exist)')
        if sub_label is None:
            tmp = os.path.basename(figpath)
            sub_label = ''.join([x if x.isalnum() else '_' for x in tmp ])

        fig = self.Fig(
            figpath=figpath, list_entry=list_entry, sub_caption=sub_caption,
            sub_label=sub_label, inc_option=include_option
        )
        self.figs.append(fig)

    def _fig_to_latex(self, fig:Fig):
        tmp = self.SINGLE_FIG.replace('__LIST_ENTRY__',fig.list_entry)
        tmp = tmp.replace('__SUB_CAPTION__',fig.sub_caption)
        if fig.sub_label == False:
            tmp = tmp.replace('\n    \\label{fig:__SUB_LABEL__}%', '')
        else:
            tmp = tmp.replace('__SUB_LABEL__', fig.sub_label)
        tmp = tmp.replace('__INC_OPTION__', fig.inc_option)
        tmp = tmp.replace('__FIGPATH__', fig.figpath)
        return tmp

    def to_latex(self, grid = False):
        latex = self.TEMPLATE.replace('__ALIGNMENT__', self.alignment)
        latex = latex.replace('__CAPTION__', self.caption)
        latex = latex.replace('__LABEL__', self.label)
        if not grid:
            tmp = map(self._fig_to_latex, self.figs)
            latex = latex.replace('__SUBFIGS__', '\n'.join(tmp))
        else:
            length = int(math.ceil(math.sqrt(len(self.figs))))
            width = 1/length
            index = 0
            tmp = ''
            for i in range(length):
                for j in range(length):
                    if index == len(self.figs): break
                    tmpfig = self.figs[index]
                    assert isinstance(tmpfig, self.Fig)
                    if 'width' in tmpfig.inc_option:
                        raise ValueError('I cannot adjust the width when you have specified one.')
                    newfig = tmpfig._replace(inc_option=tmpfig.inc_option + 'width={0:1.2f}\\textwidth'.format(width))
                    tmp = tmp + self._fig_to_latex(newfig)
                    index += 1
                if index == len(self.figs): break
                tmp = tmp + '\\\\%\n'
            latex = latex.replace('__SUBFIGS__', tmp)

        return latex


class FigTable:
    TABLE_TEMPLATE = r"""% making the tabularx vertically centered
\renewcommand{\tabularxcolumn}[1]{>{\small}m{#1}}
\begin{table}[__POSITION__]
\centering
\begin{tabularx}{\textwidth}{__COLUMN_SPEC__}
\hline
__TABLE_CONTENT__
\\
\hline
\end{tabularx}
\caption{__CAPTION__}
\label{fig:__LABEL__}
\end{table}"""
    Table = namedtuple('table', ['position', 'column_spec', 'table_content', 'caption', 'label'])
    FIG_TEMPLATE = r"""\includegraphics[width=__WIDTH__\textwidth]{__FIGPATH__}"""
    Fig = namedtuple('fig', ['width', 'figpath'])
    Row = namedtuple('row', ['name','figs'])

    def __init__(self, caption = None, top_left = '', column_names = List[str], label = None, position='h'):
        self.caption = caption
        self.top_left = top_left
        self.column_names = column_names
        if label is None:
            if caption is not None:
                self.label = ''.join([ x if x.isalnum() else '_' for x in caption])
            else:
                self.label = None
        else:
            self.label = label
        self.position = position

        self.fig_column_count = len(column_names)
        self.width = 1/(self.fig_column_count + 1)

        self.rows = []

    def add_row(self, name_of_row, row_of_figs: List[str]):
        """

        :param name_of_row:
        :param row_of_figs:  ['a.pdf', '', 'b.pdf', ...] Use '' for empty elements
        :return:
        """
        if len(row_of_figs) > self.fig_column_count: raise ValueError('Too many figures for a row')
        if len(row_of_figs) < self.fig_column_count:
            row_of_figs.extend(['' for i in range(self.fig_column_count - len(row_of_figs))])
        self.rows.append(self.Row(name=name_of_row, figs=row_of_figs))

    def _make_single_fig(self, figpath):
        if figpath == '':
            return ''
        tmp = self.FIG_TEMPLATE.replace('__WIDTH__', '{0:1.2f}'.format(self.width))
        tmp = tmp.replace('__FIGPATH__', figpath)
        return tmp

    def _make_a_row(self, row:Row):
        tmp = row.name + ' &\n'
        tmp = tmp + '&\n'.join(map(self._make_single_fig, row.figs))
        return tmp

    def _make_first_row(self):
        tmp = self.top_left + ' & '
        tmp = tmp + ' & '.join(self.column_names)
        return tmp

    def _make_all_row(self):
        tmp = self._make_first_row() + '\\\\\n'
        tmp = tmp + '\\hline\n'
        tmp = tmp + '\\\\\n'.join(map(self._make_a_row, self.rows))
        return tmp

    def to_latex(self):
        tmp = self.TABLE_TEMPLATE.replace('__POSITION__', self.position)
        col_spec = '|X| ' + r'*{__N__}{>{\centering\arraybackslash}X}@{}'.replace('__N__', str(self.fig_column_count)) + '|'
        tmp = tmp.replace('__COLUMN_SPEC__', col_spec)
        tmp = tmp.replace('__TABLE_CONTENT__', self._make_all_row())
        if self.caption is None:
            tmp = tmp.replace(r'\caption{__CAPTION__}', '')
        else:
            tmp = tmp.replace('__CAPTION__', self.caption)
        if self.label is None:
            tmp = tmp.replace(r'\label{fig:__LABEL__}', '')
        else:
            tmp = tmp.replace('__LABEL__', self.label)
        return tmp


def test_sub_fig():
    sample_fig = '20err1inc-50o100-perr20pinc1-lr1E-3.pdf'
    subfig = Subfig(caption='title', label='figlabel')
    for _ in range(10):
        subfig.add_fig(sample_fig)

    print(subfig.to_latex(grid=True))


def test_fig_table():
    figtable = FigTable(caption='caption', top_left=r'a\textbackslash b', column_names=['1', '2', '3'],
                        label='label', position='h')
    sample_fig = '20err1inc-50o100-perr20pinc1-lr1E-3.pdf'
    figtable.add_row(name_of_row='row name', row_of_figs=[sample_fig, sample_fig])
    figtable.add_row(name_of_row='row name', row_of_figs=['',sample_fig])
    print(figtable.to_latex())


if __name__ == '__main__':
    test_sub_fig()
    test_fig_table()
