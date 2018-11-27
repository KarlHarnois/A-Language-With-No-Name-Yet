import Compiler

let cli = CommandLineInterface()

do {
  try cli.run()
} catch {
  print(error.localizedDescription)
}
