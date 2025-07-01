export type readable<T> = () -> T
export type callable<T> = (value: T) -> ()

export type source<T> = callable<T> & readable<T>

return nil