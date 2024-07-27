#[macro_use]
extern crate rocket;

use rocket::response::Redirect;
use std::env;

#[get("/<_..>")]
fn everything() -> Redirect {
    Redirect::to(env::var("REDIRECT_URL").unwrap())
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![everything])
}
