module type Config = {
  type t
  let makeDefault: unit => t
  let decode: string => t
  let encode: t => string
}

module Make = (Config: Config) => {

}

let useRehydrate:
  type state. (module(Config with type t = state), string) => (option<state>, state => unit) =
  (module(Config), keyName) => {
    let (state, setState) = React.useState(_ => None)

    React.useEffect0(() => {
      setState(_ => Some(
        LocalStorage.localStorage
        ->LocalStorage.getItem(~key=keyName)
        ->Js.Null.toOption
        ->Belt.Option.mapWithDefault(Config.makeDefault(), Config.decode),
      ))
      None
    })

    let update = (value: Config.t) => {
      LocalStorage.localStorage->LocalStorage.setItem(~key=keyName, ~value=value->Config.encode)
      setState(_ => Some(value))
    }

    (state, update)
  }

let render:
  type state. (module(Config with type t = state), option<state>) => React.element =
  (module(Config), value) => {
    value
    ->Belt.Option.mapWithDefault(Config.makeDefault()->Config.encode, Config.encode)
    ->React.string
  }
