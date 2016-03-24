package hu.unideb.inf.Unizon.model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;
import java.util.List;


/**
 * The persistent class for the UNI_ORDER database table.
 * 
 */
@Entity
@Table(name="UNI_ORDER")
@NamedQuery(name="UniOrder.findAll", query="SELECT u FROM UniOrder u")
public class UniOrder implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="ORDER_ID", unique=true, nullable=false)
	private int orderId;

	@Temporal(TemporalType.DATE)
	@Column(name="ORDER_DATE")
	private Date orderDate;

	//bi-directional many-to-one association to ProdToOrder
	@OneToMany(mappedBy="uniOrder", fetch=FetchType.EAGER)
	private List<ProdToOrder> prodToOrders;

	//bi-directional many-to-one association to Address
	@ManyToOne
	@JoinColumn(name="SHIPPING_ADDRESS_ID", nullable=false)
	private Address address1;

	//bi-directional many-to-one association to Address
	@ManyToOne
	@JoinColumn(name="BILLING_ADDRESS_ID", nullable=false)
	private Address address2;

	//bi-directional many-to-one association to PhoneNumber
	@ManyToOne
	@JoinColumn(name="PHONE_NUMBER_ID", nullable=false)
	private PhoneNumber phoneNumber;

	//bi-directional many-to-one association to UniUser
	@ManyToOne
	@JoinColumn(name="USER_ID", nullable=false)
	private UniUser uniUser;

	public UniOrder() {
	}

	public int getOrderId() {
		return this.orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public Date getOrderDate() {
		return this.orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public List<ProdToOrder> getProdToOrders() {
		return this.prodToOrders;
	}

	public void setProdToOrders(List<ProdToOrder> prodToOrders) {
		this.prodToOrders = prodToOrders;
	}

	public ProdToOrder addProdToOrder(ProdToOrder prodToOrder) {
		getProdToOrders().add(prodToOrder);
		prodToOrder.setUniOrder(this);

		return prodToOrder;
	}

	public ProdToOrder removeProdToOrder(ProdToOrder prodToOrder) {
		getProdToOrders().remove(prodToOrder);
		prodToOrder.setUniOrder(null);

		return prodToOrder;
	}

	public Address getAddress1() {
		return this.address1;
	}

	public void setAddress1(Address address1) {
		this.address1 = address1;
	}

	public Address getAddress2() {
		return this.address2;
	}

	public void setAddress2(Address address2) {
		this.address2 = address2;
	}

	public PhoneNumber getPhoneNumber() {
		return this.phoneNumber;
	}

	public void setPhoneNumber(PhoneNumber phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public UniUser getUniUser() {
		return this.uniUser;
	}

	public void setUniUser(UniUser uniUser) {
		this.uniUser = uniUser;
	}

}