try:
    from rich import print
    import rich.pretty
    import rich.traceback
except ImportError:
    pass
else:
    rich.pretty.install(indent_guides=True)
    rich.traceback.install(indent_guides=True, width=None)
