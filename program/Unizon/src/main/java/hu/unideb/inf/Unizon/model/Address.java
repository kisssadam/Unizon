package hu.unideb.inf.Unizon.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the ADDRESS database table.
 * 
 */
@Entity
@Table(name="ADDRESS")
@NamedQuery(name="Address.findAll", query="SELECT a FROM Address a")
public class Address implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="ADDRESS_ID", unique=true, nullable=false)
	private int addressId;

	@Column(name="CITY", length=100)
	private String city;

	@Column(name="COUNTRY", length=100)
	private String country;

	@Column(name="DOOR")
	private int door;

	@Column(name="FLOOR")
	private int floor;

	@Column(name="STR_NUMBER")
	private int strNumber;

	@Column(name="STREET", length=100)
	private String street;

	@Column(name="ZIP")
	private int zip;

	//bi-directional many-to-one association to AddressesOfUser
	@OneToMany(mappedBy="address", fetch=FetchType.EAGER)
	private List<AddressesOfUser> addressesOfUsers;

	//bi-directional many-to-one association to Order
	@OneToMany(mappedBy="address1", fetch=FetchType.EAGER)
	private List<Order> orders1;

	//bi-directional many-to-one association to Order
	@OneToMany(mappedBy="address2", fetch=FetchType.EAGER)
	private List<Order> orders2;

	//bi-directional many-to-one association to User
	@OneToMany(mappedBy="address", fetch=FetchType.EAGER)
	private List<User> users;

	public Address() {
	}

	public int getAddressId() {
		return this.addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCountry() {
		return this.country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public int getDoor() {
		return this.door;
	}

	public void setDoor(int door) {
		this.door = door;
	}

	public int getFloor() {
		return this.floor;
	}

	public void setFloor(int floor) {
		this.floor = floor;
	}

	public int getStrNumber() {
		return this.strNumber;
	}

	public void setStrNumber(int strNumber) {
		this.strNumber = strNumber;
	}

	public String getStreet() {
		return this.street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public int getZip() {
		return this.zip;
	}

	public void setZip(int zip) {
		this.zip = zip;
	}

	public List<AddressesOfUser> getAddressesOfUsers() {
		return this.addressesOfUsers;
	}

	public void setAddressesOfUsers(List<AddressesOfUser> addressesOfUsers) {
		this.addressesOfUsers = addressesOfUsers;
	}

	public AddressesOfUser addAddressesOfUser(AddressesOfUser addressesOfUser) {
		getAddressesOfUsers().add(addressesOfUser);
		addressesOfUser.setAddress(this);

		return addressesOfUser;
	}

	public AddressesOfUser removeAddressesOfUser(AddressesOfUser addressesOfUser) {
		getAddressesOfUsers().remove(addressesOfUser);
		addressesOfUser.setAddress(null);

		return addressesOfUser;
	}

	public List<Order> getOrders1() {
		return this.orders1;
	}

	public void setOrders1(List<Order> orders1) {
		this.orders1 = orders1;
	}

	public Order addOrders1(Order orders1) {
		getOrders1().add(orders1);
		orders1.setAddress1(this);

		return orders1;
	}

	public Order removeOrders1(Order orders1) {
		getOrders1().remove(orders1);
		orders1.setAddress1(null);

		return orders1;
	}

	public List<Order> getOrders2() {
		return this.orders2;
	}

	public void setOrders2(List<Order> orders2) {
		this.orders2 = orders2;
	}

	public Order addOrders2(Order orders2) {
		getOrders2().add(orders2);
		orders2.setAddress2(this);

		return orders2;
	}

	public Order removeOrders2(Order orders2) {
		getOrders2().remove(orders2);
		orders2.setAddress2(null);

		return orders2;
	}

	public List<User> getUsers() {
		return this.users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public User addUser(User user) {
		getUsers().add(user);
		user.setAddress(this);

		return user;
	}

	public User removeUser(User user) {
		getUsers().remove(user);
		user.setAddress(null);

		return user;
	}

}