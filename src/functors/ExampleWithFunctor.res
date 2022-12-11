module DateStorageConfig = {
  type t = Js.Date.t

  let makeDefault = () => Js.Date.make()
  let encode = date => date->Js.Date.getTime->Js.Float.toString
  let decode = date => date->Js.Float.fromString->Js.Date.fromFloat
}

module DateStorage = AppLocalStorageUtils.Make(DateStorageConfig)

@react.component
let make = () => {
  let (date, updateDate) = DateStorage.useRehydrate(~keyName="date")

  let handleClick = _ => {
    updateDate(Js.Date.make())
  }

  <div className="main-container">
    <p> {`The last saved date is: `->React.string} </p>
    <p>
      {switch date {
      | Some(value) => `${value->Js.Date.toLocaleDateString} ${value->Js.Date.toLocaleTimeString}`
      | None => ""
      }->React.string}
    </p>
    <button onClick=handleClick> {`Update date`->React.string} </button>
  </div>
}
