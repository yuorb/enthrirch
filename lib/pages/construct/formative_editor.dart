import 'package:enthrirhs/utils/store.dart';
import 'package:enthrirhs/utils/types.dart' as database;
import 'package:flutter/material.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

import 'package:enthrirhs/libs/misc.dart';
import 'package:provider/provider.dart';
import '../../components/list_group_title.dart';
import '../../libs/ithkuil/mod.dart';
import '../../libs/ithkuil/terms/mod.dart';

class FormativeEditor extends StatefulWidget {
  final Formative formative;
  final void Function(void Function(Formative)) updateFormative;
  final void Function() removeFormative;

  const FormativeEditor({
    required this.formative,
    required this.updateFormative,
    required this.removeFormative,
    super.key,
  });

  @override
  State<FormativeEditor> createState() => _FormativeEditorState();
}

class _FormativeEditorState extends State<FormativeEditor> with TickerProviderStateMixin {
  String definition = 'Searching definition...';

  @override
  void initState() {
    super.initState();
    updateDefinition();
  }

  Future<String> getDefinition() async {
    final rootStr = widget.formative.root.toString().toUpperCase();
    final root = await context.read<LexiconModel>().database.exactSearch(rootStr);
    if (root == null) {
      return 'Cannot find this root in your local lexicon. Please try to import the latest lexicon or use a valid root.';
    }
    final stems = root.stems;
    if (stems != null) {
      return switch (widget.formative.stem) {
        Stem.s1 => switch (stems[0]) {
            database.Specs specs => switch (widget.formative.specification) {
                Specification.bsc => specs.bsc,
                Specification.cte => specs.cte,
                Specification.csv => specs.csv,
                Specification.obj => specs.obj
              },
            database.StrStem(value: final value) => value
          },
        Stem.s2 => switch (stems[1]) {
            database.Specs specs => switch (widget.formative.specification) {
                Specification.bsc => specs.bsc,
                Specification.cte => specs.cte,
                Specification.csv => specs.csv,
                Specification.obj => specs.obj
              },
            database.StrStem(value: final value) => value
          },
        Stem.s3 => switch (stems[2]) {
            database.Specs specs => switch (widget.formative.specification) {
                Specification.bsc => specs.bsc,
                Specification.cte => specs.cte,
                Specification.csv => specs.csv,
                Specification.obj => specs.obj
              },
            database.StrStem(value: final value) => value
          },
        Stem.s0 => root.refers != null
            ? root.refers!
            : 'Unavailable because you selected `Stem 0` but this root does not have the `refers` field in lexicon.'
      };
    }
    if (root.refers != null) {
      return root.refers!;
    }

    return 'Unavailable because this root has neither the `stems` nor the `refers` field in lexicon.';
  }

  void updateDefinition() {
    getDefinition().then((newDefinition) {
      setState(() {
        definition = newDefinition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const ListGroupTitle("Definition"),
      ListTile(
        leading: const Icon(Icons.abc),
        title: const Text("Root"),
        subtitle: Text("-${widget.formative.root.toString().toUpperCase()}-"),
        onTap: () async {
          final rootStr = await prompt(
            context,
            title: const Text("Please enter the new root"),
            initialValue: "",
          );
          if (rootStr != null) {
            final root = Root.from(rootStr);
            if (root != null && root.phonemes.isNotEmpty) {
              if (!context.mounted) return;
              widget.updateFormative((Formative f) {
                f.root = root;
              });
              updateDefinition();
            } else {
              if (!context.mounted) return;
              await showErrorDialog(context, "Invalid new root.");
            }
          }
        },
      ),
      PopupMenuButton<Stem>(
        initialValue: widget.formative.stem,
        onSelected: (Stem stem) {
          widget.updateFormative((f) {
            f.stem = stem;
          });
          updateDefinition();
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Stem>>[
          PopupMenuItem(
            value: Stem.s1,
            child: Text('Stem 1'),
          ),
          PopupMenuItem(
            value: Stem.s2,
            child: Text('Stem 2'),
          ),
          PopupMenuItem(
            value: Stem.s3,
            child: Text('Stem 3'),
          ),
          PopupMenuItem(
            value: Stem.s0,
            child: Text('Stem 0'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.library_books),
          title: const Text("Stem"),
          subtitle: Text(
            switch (widget.formative.stem) {
              Stem.s1 => 'Stem 1',
              Stem.s2 => 'Stem 2',
              Stem.s3 => 'Stem 3',
              Stem.s0 => 'Stem 0',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      PopupMenuButton<Specification>(
        initialValue: widget.formative.specification,
        onSelected: (Specification specification) {
          widget.updateFormative((f) {
            f.specification = specification;
          });
          updateDefinition();
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Specification>>[
          PopupMenuItem(
            value: Specification.bsc,
            child: Text('BSC (Basic)'),
          ),
          PopupMenuItem(
            value: Specification.cte,
            child: Text('CTE (Contential)'),
          ),
          PopupMenuItem(
            value: Specification.csv,
            child: Text('CSV (Constitutive)'),
          ),
          PopupMenuItem(
            value: Specification.obj,
            child: Text('OBJ (Objective)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.library_books),
          title: const Text("Specification"),
          subtitle: Text(
            switch (widget.formative.specification) {
              Specification.bsc => 'BSC (Basic)',
              Specification.cte => 'CTE (Contential)',
              Specification.csv => 'CSV (Constitutive)',
              Specification.obj => 'OBJ (Objective)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Text(
          definition,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      const ListGroupTitle("Basic"),
      PopupMenuButton<Version>(
        initialValue: widget.formative.version,
        onSelected: (Version version) {
          widget.updateFormative((f) {
            f.version = version;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Version>>[
          PopupMenuItem(
            value: Version.prc,
            child: Text('PRC (Processual)'),
          ),
          PopupMenuItem(
            value: Version.cpt,
            child: Text('CPT (Completive)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.library_books),
          title: const Text("Version"),
          subtitle: Text(
            switch (widget.formative.version) {
              Version.prc => 'PRC (Processual)',
              Version.cpt => 'CPT (Completive)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      PopupMenuButton<Function$>(
        initialValue: widget.formative.function,
        onSelected: (Function$ function) {
          widget.updateFormative((f) {
            f.function = function;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Function$>>[
          PopupMenuItem(
            value: Function$.sta,
            child: Text('STA (Stative)'),
          ),
          PopupMenuItem(
            value: Function$.dyn,
            child: Text('DYN (Dynamic)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.library_books),
          title: const Text("Function"),
          subtitle: Text(
            switch (widget.formative.version) {
              Version.prc => 'STA (Stative)',
              Version.cpt => 'DYM (Dynamic)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      PopupMenuButton<Context>(
        initialValue: widget.formative.context,
        onSelected: (Context thisContext) {
          widget.updateFormative((f) {
            f.context = thisContext;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Context>>[
          PopupMenuItem(
            value: Context.exs,
            child: Text('EXS (Existential)'),
          ),
          PopupMenuItem(
            value: Context.fnc,
            child: Text('FNC (Functional)'),
          ),
          PopupMenuItem(
            value: Context.rps,
            child: Text('RPS (Representational)'),
          ),
          PopupMenuItem(
            value: Context.amg,
            child: Text('AMG (Amalgamative)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.library_books),
          title: const Text("Context"),
          subtitle: Text(
            switch (widget.formative.context) {
              Context.exs => 'EXS (Existential)',
              Context.fnc => 'FNC (Functional)',
              Context.rps => 'RPS (Representational)',
              Context.amg => 'AMG (Amalgamative)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      const ListGroupTitle("Ca"),
      PopupMenuButton<Affiliation>(
        initialValue: widget.formative.affiliation,
        onSelected: (Affiliation affiliation) {
          widget.updateFormative((f) {
            f.affiliation = affiliation;
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Affiliation>>[
          PopupMenuItem(
            value: Affiliation.csl,
            child: Text('CSL (Consolidative)'),
          ),
          PopupMenuItem(
            value: Affiliation.aso,
            child: Text('ASO (Associative)'),
          ),
          PopupMenuItem(
            value: Affiliation.coa,
            child: Text('COA (Coalescent)'),
          ),
          PopupMenuItem(
            value: Affiliation.var$,
            child: Text('VAR (Variative)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.library_books),
          title: const Text("Affiliation"),
          subtitle: Text(
            switch (widget.formative.affiliation) {
              Affiliation.csl => 'CSL (Consolidative)',
              Affiliation.aso => 'ASO (Associative)',
              Affiliation.coa => 'COA (Coalescent)',
              Affiliation.var$ => 'VAR (Variative)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      PopupMenuButton<Plexity>(
        initialValue: widget.formative.configuration.plexity,
        onSelected: (Plexity newPlexity) {
          widget.updateFormative((f) {
            final similarity = f.configuration.similarity;
            final separability = f.configuration.separability;
            if (similarity == null && separability == null && newPlexity == Plexity.m) {
              f.configuration = Configuration.from(Plexity.m, Similarity.s, Separability.s)!;
            } else if (similarity != null && separability != null && newPlexity == Plexity.u) {
              f.configuration = Configuration.from(Plexity.u, null, null)!;
            } else {
              f.configuration.plexity = newPlexity;
            }
          });
        },
        offset: const Offset(1, 0),
        itemBuilder: (BuildContext context) => const <PopupMenuEntry<Plexity>>[
          PopupMenuItem(
            value: Plexity.u,
            child: Text('U (Uniplex)'),
          ),
          PopupMenuItem(
            value: Plexity.d,
            child: Text('D (Duplex)'),
          ),
          PopupMenuItem(
            value: Plexity.m,
            child: Text('M (Multiplex)'),
          ),
        ],
        child: ListTile(
          leading: const Icon(Icons.library_books),
          title: const Text("Plexity"),
          subtitle: Text(
            switch (widget.formative.configuration.plexity) {
              Plexity.u => 'U (Uniplex)',
              Plexity.d => 'D (Duplex)',
              Plexity.m => 'M (Multiplex)',
            },
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
      // TODO: Implement this option.
      widget.formative.configuration.plexity != Plexity.u
          ? ListTile(
              leading: const Icon(Icons.library_books),
              title: const Text("Similarity"),
              subtitle: const Text("BSC"),
              onTap: () {},
            )
          : Container(),
      // TODO: Implement this option.
      widget.formative.configuration.plexity != Plexity.u
          ? ListTile(
              leading: const Icon(Icons.library_books),
              title: const Text("Separability"),
              subtitle: const Text("BSC"),
              onTap: () {},
            )
          : Container(),
      // TODO: Implement this option.
      ListTile(
        leading: const Icon(Icons.library_books),
        title: const Text("Extension"),
        subtitle: const Text("BSC"),
        onTap: () {},
      ),
      // TODO: Implement this option.
      ListTile(
        leading: const Icon(Icons.library_books),
        title: const Text("Perspective"),
        subtitle: const Text("BSC"),
        onTap: () {},
      ),
      // TODO: Implement this option.
      ListTile(
        leading: const Icon(Icons.library_books),
        title: const Text("Essence"),
        subtitle: const Text("BSC"),
        onTap: () {},
      ),
      const ListGroupTitle("Relation etc."),
      // TODO: Implement this option.
      ListTile(
        leading: const Icon(Icons.library_books),
        title: const Text("Essence"),
        subtitle: const Text("BSC"),
        onTap: () {},
      ),
      // TODO: Implement this option.
      ListTile(
        leading: const Icon(Icons.library_books),
        title: const Text("Case"),
        subtitle: const Text("BSC"),
        onTap: () {},
      ),
      // TODO: Implement this option.
      // ListTile(
      //   leading: const Icon(Icons.library_books),
      //   title: const Text("Illocution"),
      //   subtitle: const Text("BSC"),
      //   onTap: () {},
      // ),
      // TODO: Implement this option.
      // ListTile(
      //   leading: const Icon(Icons.library_books),
      //   title: const Text("Validation"),
      //   subtitle: const Text("BSC"),
      //   onTap: () {},
      // ),
      const ListGroupTitle("VnCn"),
      // TODO: Implement this option.
      ListTile(
        leading: const Icon(Icons.library_books),
        title: const Text("Vn"),
        subtitle: const Text("BSC"),
        onTap: () {},
      ),
      // TODO: Implement this option.
      ListTile(
        leading: const Icon(Icons.library_books),
        title: const Text("Cn"),
        subtitle: const Text("BSC"),
        onTap: () {},
      ),
      // TODO: Implement this option.
      ListGroupTitle(
        "Affixes CsVx",
        trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
      ),
      // TODO: Implement this option.
      ListGroupTitle(
        "Affixes VxCs",
        trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
      ),
      const ListGroupTitle("Operation"),
      ListTile(
        leading: const Icon(Icons.delete),
        title: const Text("Delete"),
        subtitle: const Text("Delete this formative"),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) => AlertDialog(
              title: const Text("Confirm"),
              content: const Text("Are you sure to remove this formative?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(dialogContext);
                    widget.removeFormative();
                  },
                  child: const Text("Ok"),
                ),
              ],
            ),
          );
        },
        tileColor: Theme.of(context).colorScheme.errorContainer,
      ),
    ]);
  }
}
