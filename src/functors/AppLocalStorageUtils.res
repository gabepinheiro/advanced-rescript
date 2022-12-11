open LocalStorage

module type Config = {
  type t
  let makeDefault: unit => t
  let encode: t => string
  let decode: string => t
}

module Make = (Config: Config) => {
  let useRehydrate = (~keyName: string) => {
    let (state, setState) = React.useState(_ => None)

    React.useEffect0(() => {
      setState(_ => {
        Some(
          localStorage
          ->getItem(~key=keyName)
          ->Js.Null.toOption
          ->Belt.Option.mapWithDefault(Config.makeDefault(), value => value->Config.decode),
        )
      })
      None
    })

    let update = (value: Config.t) => {
      localStorage->setItem(~key=keyName, ~value=value->Config.encode)
      setState(_ => Some(value))
    }

    (state, update)
  }
}
